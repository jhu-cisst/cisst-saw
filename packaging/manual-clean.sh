#!/bin/bash

echo "apt remove"
sudo apt remove cisst cisstnetlib-fortran

echo "/usr/local rm for cisst/SAW files"
sudo rm -rf /usr/local/lib/libsaw*
sudo rm -rf /usr/local/bin/saw*
sudo find /usr/local/ -name "*cisst*" -exec rm -r {} \;
