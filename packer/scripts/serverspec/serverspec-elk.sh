#!/bin/bash -eux

echo "***** Copying Serverspec Tests x Jenkins *****"

cp /tmp/elk/tests/*.rb   /tmp/serverspec/spec/localhost/
