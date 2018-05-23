#!/bin/bash -e

echo "Remove older version ..."
sudo apt-get remove -y docker docker-engine docker.io

echo "Setup the repository ..."
sudo apt-get update -y

echo "Install package to allow apt to use a repository over HTTPS"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Add docker official GPG Key ..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Verify fingerprints"
sudo apt-key fingerprint 0EBFCD88

echo "Setup the stable repo"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Update the package index with the new repo ..."
sudo apt-get update -y

echo "Install docker-ce"
sudo apt-get install -y docker-ce

echo "Post installation task to avoid to use docker with sudo"
#sudo groupadd docker

echo "Add the current user to the group docker"
sudo usermod -aG docker $USER

echo "Verify docker installation"

echo "Show the daemon process ..."
sudo ps aux |grep dockerd

echo "Show the docker version ..."
sudo docker version