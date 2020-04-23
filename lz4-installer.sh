#!/bin/bash

apt update -qq
apt install -y checkinstall build-essential
rm /usr/local/bin/{lz4c,lz4cat,unlz4} 2>/dev/null
cd /tmp
wget https://github.com/lz4/lz4/archive/v1.9.2.tar.gz -O lz4.tar.gz
tar -xf lz4.tar.gz
cd lz4-1.9.2
make
echo y | checkinstall
if ! grep -qx lz4 /etc/initramfs-tools/modules; then echo lz4 >> /etc/initramfs-tools/modules; fi
if ! grep -qx lz4_compress /etc/initramfs-tools/modules; then echo lz4_compress >> /etc/initramfs-tools/modules; fi
update-initramfs -u -k all
