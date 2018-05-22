#!/bin/bash -e

echo "***** Starting NGINX installation"

echo "      Adding the EPEL Release repository"
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

echo "      Adding NGINX repository "
sudo yum -y install epel-release

echo "      Install NGINX "
sudo yum -y install nginx

echo "      Start NGINX  "
sudo systemctl start nginx

echo "      Opening Firewal ports for http and https "
#sudo firewall-cmd --permanent --zone=public --add-service=http
#sudo firewall-cmd --permanent --zone=public --add-service=https
#sudo firewall-cmd --reload

echo "      Enable NGINX to start at the system boot "
sudo systemctl enable nginx