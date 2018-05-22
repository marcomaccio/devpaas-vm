#!/bin/bash -e

echo "******* LogStash Installation *******"

sudo apt-get update && sudo apt-get install logstash

sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private

sudo systemctl daemon-reload
sudo systemctl enable logstash
sudo systemctl start logstash
