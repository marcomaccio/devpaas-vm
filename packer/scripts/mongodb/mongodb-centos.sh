#!/bin/bash -ex

sudo cp /tmp/mongodb/configs/mongodb-org.repo /etc/yum.repos.d/
sudo chown root:root /etc/yum.repos.d/mongodb-org.repo

yum repolist | grep mongo

sudo yum -y install mongodb-org

sudo systemctl start mongod