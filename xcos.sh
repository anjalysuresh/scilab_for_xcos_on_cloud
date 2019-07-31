#!/bin/bash

test $( id -u ) -eq 0 && { echo "Do not run this script as root"; exit 1; }
sudo -v

set -ex
cd ~

sudo sed -i.orig 's/^#* *\(deb\(-src\)\? \)/\1/' /etc/apt/sources.list

sudo apt update  
sudo apt upgrade -y 
sudo apt build-dep -y scilab  
sudo apt install -y libgfortran3 git

rm -rf scilab_for_xcos_on_cloud 
git clone -b master6 https://github.com/FOSSEE/scilab_for_xcos_on_cloud 

cd scilab_for_xcos_on_cloud
./configure --disable-static-system-lib
make -j4 
./bin/scilab-adv-cli -e 'quit()'
echo 'Done'
exit 0

