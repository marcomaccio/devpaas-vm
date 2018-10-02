#!/bin/bash -e

echo "**************************************************************"
echo "***** Start installation of Ubuntu Desktop *****"

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y ubuntu-desktop

echo "  Change permission to .Xauthority, .ICEauthority, .config "
sudo chown $USER:$( id -g -n $USER) .Xauthority
sudo chown $USER:$( id -g -n $USER) .ICEauthority
sudo chown -R $USER:$( id -g -n $USER) .config/

echo "***** installation of Ubuntu Desktop  Ended *****"
echo "***************************************************************"