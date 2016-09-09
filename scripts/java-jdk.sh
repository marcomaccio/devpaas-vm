#!/bin/bash -e
echo "***** JAVA JDK installation"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
