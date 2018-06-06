#!/bin/bash -eux

echo "*****************************************************"
echo "***** Start installation of Angular CLI via npm *****"

sudo npm install -g @angular/cli

ng config -g cli.packageManager yarn

echo "***** installation of Angular CLI via npm Ended *****"
echo "*****************************************************"