#!/bin/bash -e
echo "***** Ruby installation *****"
sudo apt-get -y install ruby

echo "***** Serverspec installation by gem *****"
sudo gem install serverspec

echo "***** Running Serverspec Tests *****"
cd /tmp/serverspec
if [ ! -d "/tmp/serverspec/spec/localhost" ]; then
  mkdir /tmp/serverspec/spec/localhost
fi
