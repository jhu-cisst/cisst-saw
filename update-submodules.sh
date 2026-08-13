#!/usr/bin/env bash

# Update this repository and every initialized submodule to a remote branch.
# Local changes are never overwritten; commit or stash them before running.

set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: $0 BRANCH [SUBMODULE_PATH]" >&2
    exit 2
fi

requested_branch=$1

update_repository() {
    local repository=$1

    if [[ -n "$(git status --short)" ]]; then
        echo "${repository}: has local changes; refusing to update" >&2
        return 1
    fi

    git fetch --prune origin

    local branch=${requested_branch}
    if ! git show-ref --verify --quiet "refs/remotes/origin/${branch}"; then
        branch=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null \
                 || printf 'origin/master')
        branch=${branch#origin/}
        echo "${repository}: origin/${requested_branch} is unavailable; using origin/${branch}" >&2
    fi

    if git show-ref --verify --quiet "refs/heads/${branch}"; then
        git switch "${branch}"
    else
        git switch --track -c "${branch}" "origin/${branch}"
    fi

    git pull --ff-only origin "${branch}"
    echo "${repository}: $(git rev-parse --short HEAD)"
}

if [[ $# -eq 2 ]]; then
    update_repository "$2"
    exit 0
fi

root_repository=$(git rev-parse --show-toplevel)
cd "${root_repository}"

git submodule sync --recursive

# Check all already initialized submodules before update can change any
# checkout.  This keeps local work safe, including work in nested submodules.
git submodule foreach --recursive '
    if [ -n "$(git status --short)" ]; then
        echo "$name: has local changes; commit or stash them before updating" >&2
        exit 1
    fi
'

git submodule update --init --recursive

if [[ -n "$(git status --short)" ]]; then
    echo "${root_repository}: has local changes; leaving the superproject unchanged" >&2
else
    update_repository "${root_repository}"
fi
git submodule foreach --recursive "bash '${root_repository}/update-submodules.sh' '${requested_branch}' \"\$name\""
