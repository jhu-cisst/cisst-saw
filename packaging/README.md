
# Scripts

To generate all packages:
```sh
  ./generate-packages.sh
```

To cleanup debian packages and files install in /usr/local if the script fails and stops before cleaning up:
```sh
  ./manual-clean.sh
```


# Useful commands

* List content of a `.deb`: `dpkg -c xyz.name`
* List package info: `dpkg -I xyz.deb`
* Rename package using dpkg convention: `dpkg-name xyz.deb`