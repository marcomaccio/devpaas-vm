#!/bin/bash -eux

echo "***** Copying Serverspec Tests x Sonarqube *****"

cp /tmp/sonarqube/tests/*.rb /tmp/serverspec/spec/localhost/