#!/bin/bash -eux

if [ ! -d "/tmp/serverspec/spec/localhost" ]; then
  mkdir /tmp/serverspec/spec/localhost
fi

echo "***** Copying Serverspec Tests x Jenkins *****"
cp /tmp/elk/tests/*.rb   /tmp/serverspec/spec/localhost/
