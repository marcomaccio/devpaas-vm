#!/bin/bash -ex

echo "Starting NGINX installation ..."

echo "***** NGINX installation from apt-get"
sudo apt-get -y install nginx

echo "***** Verify NGINX configuration "
sudo nginx -t

echo "***** Restart NGINX service to verify that restart works"
sudo systemctl restart nginx

echo "***** Copy configurations in /home/ubuntu dir to make them available at startup"
mkdir /home/ubuntu/nginx
sudo cp -r /tmp/nginx/configs /home/ubuntu/nginx/
