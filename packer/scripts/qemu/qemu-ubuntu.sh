#!/bin/bash -ex

echo "Installing qemu package ..."
sudo apt-get -y install qemu-system

echo "Verify qemu package installation ..."
qemu-system-x86_64 --version