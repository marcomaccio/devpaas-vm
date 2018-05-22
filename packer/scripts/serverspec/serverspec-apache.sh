#!/bin/bash -e

echo "***** Running Serverspec Tests x Apache *****"

cp /tmp/apache/tests/*.rb   /tmp/serverspec/spec/localhost/
cp /tmp/mysql/tests/*.rb     /tmp/serverspec/spec/localhost/
