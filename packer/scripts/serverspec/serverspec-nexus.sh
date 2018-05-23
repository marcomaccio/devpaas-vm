#!/bin/bash -eux

echo "***** Copying Serverspec Tests x Nexus *****"

cp /tmp/nexus/tests/*.rb     /tmp/serverspec/spec/localhost/
