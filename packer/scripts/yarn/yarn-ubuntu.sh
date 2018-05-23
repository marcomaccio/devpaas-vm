#!/bin/bash -eux

echo "**************************************"
echo "***** Start installation of YARN *****"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update -y && sudo apt-get install -y yarn

yarn --version

echo "***** installation of YARN  Ended *****"
echo "***************************************"