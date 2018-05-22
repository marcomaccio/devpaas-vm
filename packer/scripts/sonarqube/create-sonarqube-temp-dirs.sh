#!/bin/bash -e

echo '****** Preparing /tmp directories for sonarqube ******'
mkdir -p /tmp/sonarqube/resources
mkdir -p /tmp/sonarqube/plugins
mkdir -p /tmp/sonarqube/tests

echo '****** Display created /tmp/sonarqube directories ******'
ls -al /tmp/sonarqube