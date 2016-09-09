#!/bin/bash -e

mkdir /home/packer/.ssh
wget --no-check-certificate \
    'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' \
    -O /home/packer/.ssh/authorized_keys
chown -R packer /home/packer/.ssh
