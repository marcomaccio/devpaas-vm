#!/bin/bash -eux

echo "***** Copying Serverspec Tests x MongoDB *****"

cp /tmp/mongodb/tests/*.rb   /tmp/serverspec/spec/localhost/

