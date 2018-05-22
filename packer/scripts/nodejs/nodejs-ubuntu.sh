#!/bin/bash -eux

echo "***** Node, NPM installation *****"
sudo apt-get -y update

curl -sL https://deb.nodesource.com/setup_7.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt-get -y install nodejs build-essential

sudo ln -s `which nodejs` /usr/local/bin/node

sudo npm install -g pm2

sudo npm install -g @angular/cli@latest
sudo npm install -g @angular/compiler@^2.3.1 @angular/compiler-cli@^2.3.1 @angular/core@^2.3.1 @angular/tsc-wrapped@^0.5.0 @ngtools/webpack
sudo npm install -g typescript@^2.0.2 zone.js@^0.7.2

# Then it should get the dist of the NODE HE app
# launch it with pm2 start server.js
# Then it should get the dist of the Angular2 FE app
# launch it with pm2 start server.js
