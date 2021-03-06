#!/bin/bash -ex

echo "Create environment variable for correct distribution ..."
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

echo "Add the Cloud SDK distribution URI as a package source ..."
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo "Import the Google Cloud Platform public key ..."
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Update the package list and install the Cloud SDK ..."
sudo apt-get update && sudo apt-get -y install google-cloud-sdk