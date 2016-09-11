#!/bin/bash -e
echo "IMAGE CREATION PART ..."

date

echo "Packaging Jenkins Server..."
rm -rf output-virtualbox-iso
packer build packer-jenkins.json
echo "Jenkins Server Packaged !"

echo "Packaging Agilefant Server..."

echo "Agilefant Server Packaged !"

echo "Packaging Gitlab Server..."

echo "Gitlab Server Packaged !"

echo "Packaging Nexus Server..."

echo "Nexus Server Packaged !"

echo "Packaging Sonarqube Server..."

echo "Sonarqube Server Packaged !"

echo "Packaging Elastic, Logstash, Kibana (ELK) Server..."
rm -rf output-virtualbox-iso
packer build packer-jenkins.json
echo "Elastic, Logstash, Kibana (ELK) Server Packaged !"

echo "Packaging NGINX Server..."

echo "NGINX Server Packaged !"

echo "IMAGE CREATION PART ended successfully !"

echo "VM CREATION PART ..."

echo "VM CREATION PART ended successfully !"

date
