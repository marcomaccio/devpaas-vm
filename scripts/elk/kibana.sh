#!/bin/bash -e
echo "Kibana Installation ..."
echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get install -y kibana
sudo systemctl daemon-reload
sudo systemctl enable kibana
sudo systemctl start kibana
