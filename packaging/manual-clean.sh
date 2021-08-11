#!/bin/bash

echo "apt remove"
sudo apt remove cisst cisstnetlib-fortran

echo "/usr/local rm for cisst/SAW files"
sudo rm -rf /usr/local/include/cisst*
sudo rm -rf /usr/local/lib/libcisst*
sudo rm -rf /usr/local/lib/libsaw*
sudo rm -rf /usr/local/bin/saw*
sudo rm -rf /usr/local/share/cisst*
