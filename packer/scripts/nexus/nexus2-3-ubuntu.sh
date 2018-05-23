#!/bin/bash -eux

echo "***** Nexus user creation *****"
sudo adduser --no-create-home --disabled-login --disabled-password nexus

mkdir $HOME/nexus/

echo "***** Download Nexus 2 *****"

wget --no-check-certificate \
 'https://download.sonatype.com/nexus/oss/nexus-2.14.2-01-bundle.tar.gz' \
 -O $HOME/nexus/nexus-2.14.2-01-bundle.tar.gz

sudo mkdir /var/lib/sonatype
sudo cp $HOME/nexus/nexus-2.14.2-01-bundle.tar.gz /var/lib/sonatype/

cd /var/lib/sonatype/

echo "***** Extract Nexus 2 *****"
sudo tar xvzf nexus-2.14.2-01-bundle.tar.gz
sudo ln -s nexus-2.14.2-01 nexus
sudo rm -f nexus-2.14.2-01-bundle.tar.gz

echo "***** Download Nexus 3 *****"
wget --no-check-certificate \
 'https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.1.0-04-unix.tar.gz' \
 -O $HOME/nexus/nexus-3.1.0-04-unix.tar.gz

sudo cp $HOME/nexus/nexus-3.1.0-04-unix.tar.gz /var/lib/sonatype/
cd /var/lib/sonatype/

echo "***** Extract Nexus 3 *****"
sudo tar xvzf nexus-3.1.0-04-unix.tar.gz
sudo ln -s nexus-3.1.0-04 nexus
sudo rm -f nexus-3.1.0-04-unix.tar.gz


echo "***** Create some dirs for Nexus *****"
sudo mkdir -p nexus/bin/jsw/conf/
sudo mkdir -p sonatype-work/home/
sudo chown -R nexus:nexus /var/lib/sonatype

