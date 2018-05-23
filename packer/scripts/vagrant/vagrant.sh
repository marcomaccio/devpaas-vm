#!/bin/bash -e

mkdir $HOME/.ssh
wget --no-check-certificate \
    'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' \
    -O $HOME/.ssh/authorized_keys
chown -R $USER $HOME/.ssh
