#!/bin/bash -e
echo "Logstash Installation ..."
echo "deb http://packages.elastic.co/logstash/2.3/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get install -y logstash
