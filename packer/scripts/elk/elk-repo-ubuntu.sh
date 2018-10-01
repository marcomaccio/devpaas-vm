#!/bin/bash -ex

echo " Download and install the public signing key:"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo 'installing apt-transport-https package'
sudo apt-get install apt-transport-https

echo 'Save the repository definition to /etc/apt/sources.list.d/elastic-6.x.list'
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list