#!/bin/bash -e

echo '****** Disable apt-daily service and timer ******'
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer

#sudo systemctl status apt-daily.service
sleep 30s

echo '****** Updating OS ******'
sudo apt-get -y update
