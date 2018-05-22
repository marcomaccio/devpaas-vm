#!/bin/bash -e

echo '****** Preparing /tmp directories for Jenkins ******'
mkdir -p /tmp/jenkins
mkdir -p /tmp/jenkins/scripts
mkdir -p /tmp/jenkins/configs
mkdir -p /tmp/jenkins/jobs
mkdir -p /tmp/jenkins/tests

echo '****** Display created /tmp/jenkins directories ******'
ls -al /tmp/jenkins