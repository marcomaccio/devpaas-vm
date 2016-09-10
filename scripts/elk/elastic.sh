#!/bin/bash -e
echo "Elastic Installation ..."
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
sudo apt-get -y update
sudo apt-get install -y elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
