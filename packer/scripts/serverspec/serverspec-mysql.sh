#!/bin/bash -eux

echo "***** Copying Serverspec Tests x MySQL *****"

cp /tmp/mysql/tests/*.rb   /tmp/serverspec/spec/localhost/

