#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# order matters!
REPOSITORIES="cisstNetlib cisst sawKeyboard sawTextToSpeech sawControllers sawRobotIO1394"

# create build directory
BUILD_DIR=$SCRIPT_DIR/../build
mkdir -p $BUILD_DIR
BUILD_DIR="$( cd $BUILD_DIR && pwd )"

PKG_DIR=$BUILD_DIR"/packages/$(lsb_release -si)-$(lsb_release -sr)"
mkdir -p $PKG_DIR
rm -f $PKG_DIR/*.deb

echo "Packages will be copied to $PKG_DIR"

# CMake options for all projects
# Release mode and strip binaries
CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS=\"-s\" -DCMAKE_CXX_FLAGS=\"-s\""

# generate packages
for repo in $REPOSITORIES;do
  echo "Building package for $repo"
  PKG_BUILD_DIR=$BUILD_DIR/$repo
  mkdir -p $PKG_BUILD_DIR
  CMAKE_CONFIG=$SCRIPT_DIR/$repo-cpack-debian.cmake
  if [ -f "$CMAKE_CONFIG" ]; then
    cd $PKG_BUILD_DIR && cmake $CMAKE_OPTS -C $CMAKE_CONFIG $SCRIPT_DIR/../$repo
  else
    cd $PKG_BUILD_DIR && cmake $CMAKE_OPTS $SCRIPT_DIR/../$repo
  fi

  # compile
  cd $PKG_BUILD_DIR && make -j

  # make install so shared libraries can be found during make package
  cd $PKG_BUILD_DIR && sudo make install
  cd $PKG_BUILD_DIR && sudo chmod 666 install_manifest*.txt

  # remove all existing old packages and then make for this repo
  cd $PKG_BUILD_DIR && rm -f *.deb
  cd $PKG_BUILD_DIR && make package

  # remove the "manually" installed package
  sudo xargs rm -fv < $PKG_BUILD_DIR/install_manifest*.txt

  # install all the packages generated
  sudo dpkg --install $PKG_BUILD_DIR/*.deb

  # list and move the generated packages
  REPO_PKGS="$(ls $PKG_BUILD_DIR/*.deb)"
  for pkg in $REPO_PKGS;do
    echo "Found generated package $pkg"
    mv $pkg $PKG_DIR
  done

done

# Run dpkg-name on all generate packages
ALL_PKGS=""
ALL_PKG_DEBS=$(ls $PKG_DIR/*.deb)
for pkg in $ALL_PKG_DEBS; do
    ALL_PKGS="$ALL_PKGS $(dpkg-deb -f $pkg Package)"
    dpkg-name $pkg
done

# Remove all installed pkgs
echo "Removing all installed packages: $ALL_PKGS"
sudo apt remove $ALL_PKGS
