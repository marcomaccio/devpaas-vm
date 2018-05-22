#!/bin/bash -e

echo "***** Nexus user creation *****"
sudo adduser --no-create-home --disabled-login --disabled-password --gecos "" nexus

echo "***** Download Nexus 3 *****"
mkdir -p $HOME/nexus/
wget --no-check-certificate \
 'https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.5.1-02-unix.tar.gz' \
 -O $HOME/nexus/nexus-3.5.1-02-unix.tar.gz

echo "***** Create Sonatype dir and copy the tar.gz file *****"
sudo mkdir /var/lib/sonatype
sudo cp $HOME/nexus/nexus-3.5.1-02-unix.tar.gz /var/lib/sonatype/

echo "***** Extract Nexus *****"
cd /var/lib/sonatype/
sudo tar xvzf nexus-3.5.1-02-unix.tar.gz

echo "***** Create Symbolic link for nexus *****"
sudo ln -s nexus-3.5.1-02 nexus

echo "***** Delete tar file *****"
sudo rm -f nexus-3.5.1-02-unix.tar.gz

echo "***** Create some conf dirs for Nexus *****"

sudo mkdir nexus/bin/jsw
sudo mkdir nexus/bin/jsw/conf/

echo "***** Create working-home for Nexus *****"
sudo mkdir -p sonatype-work/home/
sudo chown -R nexus:nexus /var/lib/sonatype

echo '****** Configure Nexus Service ******'
sudo cp /tmp/nexus/resources/nexus.service        /etc/systemd/system/
#sudo cp /tmp/nexus/resources/wrapper.conf         /var/lib/sonatype/nexus/bin/jsw/conf/

sudo chown -R nexus:nexus /var/lib/sonatype/nexus/bin/jsw/conf/

echo "***** Reload, Enble & Start Nexus service *****"
sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service
