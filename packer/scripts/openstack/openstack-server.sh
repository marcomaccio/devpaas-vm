#!/bin/bash -ex

echo "********************************************"
echo "***** Start installation of OPENSTACK  *****"

sudo useradd -s /bin/bash -d /opt/stack -m stack

echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

sudo -i -u stack git clone https://git.openstack.org/openstack-dev/devstack

sudo -i -u stack cp samples/local.conf .

sudo -i -u stack sed -i "s/#HOST_IP=w.x.y.z/HOST_IP=10.0.2.15/g;"

sudo -i -u stack ./devstack/stack.sh

echo "***** installation of OPENSTACK  Ended *****"
echo "********************************************"