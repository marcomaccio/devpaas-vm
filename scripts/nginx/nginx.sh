#!/bin/bash -e
echo "***** Starting NGINX configuration"
sudo sed -i 's/~~JENKINS_IP~~/'$JENKINS_IP'/' /tmp/resources/default.conf
sudo cp /tmp/default.conf /etc/nginx/sites-enabled/default
sudo service nginx reload
