#!/bin/bash -eux

echo "***** Setting Mysql Server root password *****"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password devpaas'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password devpaas'

echo "***** Install Mysql Server *****"
sudo apt-get -y install mysql-server
