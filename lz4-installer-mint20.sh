#!/bin/bash

apt update -qq
apt install -y checkinstall build-essential
rm /usr/local/bin/{lz4c,lz4cat,unlz4} 2>/dev/null
cd $(mktemp -d)
wget https://github.com/lz4/lz4/archive/v1.9.3.tar.gz
tar -xf *.tar.gz
cd lz4-*
make
echo y | checkinstall
if ! grep -qx lz4 /etc/initramfs-tools/modules; then echo lz4 >> /etc/initramfs-tools/modules; fi
if ! grep -qx lz4_compress /etc/initramfs-tools/modules; then echo lz4_compress >> /etc/initramfs-tools/modules; fi
update-initramfs -u -k all
