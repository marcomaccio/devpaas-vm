#!/bin/bash -e

echo '****** Upgrading OS ******'
sudo apt-get -y upgrade

echo '****** Cleaninging OS ******'
sudo apt-get autoremove
