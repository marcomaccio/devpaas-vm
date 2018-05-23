#!/bin/bash -eux

echo "**************************************************************"
echo "***** Start installation of NodeJS ${NODE_VERSION} & NPM *****"

sudo apt-get -y update

curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt-get -y install nodejs build-essential

sudo ln -s `which nodejs` /usr/local/bin/node

node --version

npm --version

echo "Clear the cache"
npm cache verify

sudo npm install -g pm2

echo "***** installation of NodeJS ${NODE_VERSION} & NPM  Ended *****"
echo "***************************************"

# Then it should get the dist of the NODE HE app
# launch it with pm2 start server.js
# Then it should get the dist of the Angular2 FE app
# launch it with pm2 start server.js
