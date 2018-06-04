#!/bin/bash -e

if [ ! -d "/tmp/serverspec/spec/localhost" ]; then
  mkdir /tmp/serverspec/spec/localhost
fi

echo "***** Running Serverspec Tests x Apache *****"
cp /tmp/apache/tests/*.rb   /tmp/serverspec/spec/localhost/