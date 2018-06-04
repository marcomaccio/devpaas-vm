#!/bin/bash -eux

if [ ! -d "/tmp/serverspec/spec/localhost" ]; then
  mkdir /tmp/serverspec/spec/localhost
fi

echo "***** Copying Serverspec Tests x Nexus *****"
cp /tmp/nexus/tests/*.rb     /tmp/serverspec/spec/localhost/