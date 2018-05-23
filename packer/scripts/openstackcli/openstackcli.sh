#!/bin/bash -ex

echo "Installing Openstack client ..."
pip install --user python-openstackclient

echo "Verify Openstack client installation"
openstack --version