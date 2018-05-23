#!/bin/bash -ex

echo "Installing awscli via pip ..."
pip install --user awscli

echo "Verify awscli installation ..."
aws --version