#!/bin/bash -eux

echo "***** Nexus user creation *****"
sudo adduser --no-create-home --disabled-login --disabled-password --gecos "" nexus

echo "***** Download Nexus 2 *****"
mkdir -p $HOME/nexus/
wget --no-check-certificate \
 'https://download.sonatype.com/nexus/oss/nexus-2.14.2-01-bundle.tar.gz' \
 -O $HOME/nexus/nexus-2.14.2-01-bundle.tar.gz

echo "***** Create Sonatype dir and copy the tar.gz file *****"
sudo mkdir /var/lib/sonatype
sudo cp $HOME/nexus/nexus-2.14.2-01-bundle.tar.gz /var/lib/sonatype/

echo "***** Extract Nexus 2 *****"
cd /var/lib/sonatype/
sudo tar xvzf nexus-2.14.2-01-bundle.tar.gz
sudo ln -s nexus-2.14.2-01 nexus
sudo rm -f nexus-2.14.2-01-bundle.tar.gz

echo "***** Create some dirs for Nexus *****"
sudo mkdir -p nexus/bin/jsw/conf/
sudo mkdir -p sonatype-work/home/
sudo chown -R nexus:nexus /var/lib/sonatype

echo '****** Nexus Service Configuration ******'
sudo cp /tmp/nexus/resources/nexus.service        /etc/systemd/system/
sudo cp /tmp/nexus/resources/wrapper.conf         /var/lib/sonatype/nexus/bin/jsw/conf/

sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service
