#!/bin/bash -e

echo "******* Kibana Installation *******"

sudo apt-get update && sudo apt-get install kibana

echo "Copy Kibana config file ..."

sudo cp /tmp/elk/resources/kibana.yml /etc/kibana/
sudo chown root:root /etc/kibana/kibana.yml

sudo systemctl daemon-reload
sudo systemctl enable kibana

echo "Start Kibana service ..."
sudo systemctl start kibana
