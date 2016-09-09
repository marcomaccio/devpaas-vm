#!/bin/bash -e
apt-get install -y linux-headers-$(uname -r) build-essential dkms

cd /tmp
mkdir /tmp/isomount
mount -t iso9660 -o loop /home/packer/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount isomount
rm -rf isomount /home/packer/VBoxGuestAdditions.iso
