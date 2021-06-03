#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PACKAGES="cisstNetlib cisst sawKeyboard sawTextToSpeech"

# create build directory
BUILD_DIR=$SCRIPT_DIR/../build
mkdir -p $BUILD_DIR
BUILD_DIR="$( cd $BUILD_DIR && pwd )"

PKG_DIR=$BUILD_DIR/packages
mkdir -p $PKG_DIR
echo "Packages will be copied to $PKG_DIR"

# remove installed versions of packages
for package in $PACKAGES; do
    echo "Removing installed package for $package"
    sudo apt remove $package
done

# CMake options for all projects
CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release" #  -DCMAKE_MODULE_LINKER_FLAGS=\"-s\""

# Generate packages
for package in $PACKAGES;do
  echo "Building package for $package"
  PKG_BUILD_DIR=$BUILD_DIR/$package
  mkdir -p $PKG_BUILD_DIR
  CMAKE_CONFIG=$SCRIPT_DIR/$package-cpack-debian.cmake
  if [ -f "$CMAKE_CONFIG" ]; then
      cd $PKG_BUILD_DIR && cmake $CMAKE_OPTS -C $CMAKE_CONFIG $SCRIPT_DIR/../$package
  else
      cd $PKG_BUILD_DIR && cmake $CMAKE_OPTS $SCRIPT_DIR/../$package
  fi
  cd $PKG_BUILD_DIR && make -j
  cd $PKG_BUILD_DIR && make package
  cp $PKG_BUILD_DIR/*.deb $PKG_DIR
  sudo dpkg --install $PKG_DIR/$package*.deb
done
