#!/usr/bin/env bash

echo "Installing pip ..."
sudo apt-get -y install python-pip

echo "Verify pip installation"
pip -V

#echo "Update pip to the latest version"
#pip install --upgrade pip