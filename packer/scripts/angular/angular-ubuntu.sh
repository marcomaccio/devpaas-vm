#!/bin/bash -eux

echo "**************************************"
echo "***** Start installation of Angular *****"
sudo npm install -g @angular/cli

ng config -g cli.packageManager yarn

echo "***** installation of Angular  Ended *****"
echo "***************************************"