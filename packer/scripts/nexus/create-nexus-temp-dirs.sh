#!/bin/bash -e

echo '****** Preparing /tmp directories for Nexus ******'

mkdir -p /tmp/nexus/resources
mkdir -p /tmp/nexus/resources/nexus2
mkdir -p /tmp/nexus/resources/nexus3
mkdir -p /tmp/nexus/tests

echo '****** Display created /tmp/nexus directories ******'
ls -al /tmp/nexus