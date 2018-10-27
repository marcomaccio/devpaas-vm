#!/bin/bash -eux

echo "*****************************************************"
echo "***** Start installation of Angular CLI via npm  NG Version: ${NG_VERSION} *****"

sudo npm install -g @angular/cli@${NG_VERSION}

echo "***** installation of Angular CLI via npm Ended *****"
echo "*****************************************************"