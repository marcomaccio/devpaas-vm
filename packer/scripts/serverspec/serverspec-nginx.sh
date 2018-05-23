#!/bin/bash -eux

echo "***** Copying Serverspec Tests x NGINX *****"

cp /tmp/nginx/tests/*.rb   /tmp/serverspec/spec/localhost/

