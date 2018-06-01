#!/bin/bash -e

echo "**************************************************************"
echo "***** Start installation of Ubuntu Desktop *****"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y ubuntu-desktop

echo "***** installation of Ubuntu Desktop  Ended *****"
echo "***************************************************************"