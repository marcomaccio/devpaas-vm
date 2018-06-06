#!/bin/bash -eux

echo "******************************************************"
echo "***** Start installation of Angular CLI via yarn *****"

sudo yarn global add @angular/cli

ng config -g cli.packageManager yarn

echo "***** installation of Angular CLI via yarn Ended *****"
echo "******************************************************"