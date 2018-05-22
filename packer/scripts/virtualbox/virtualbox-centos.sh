#!/bin/bash -e
yum install -y linux-headers-$(uname -r) build-essential dkms

cd /tmp
mkdir /tmp/isomount
mount -t iso9660 -o loop $HOME/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount isomount
rm -rf isomount $HOME/VBoxGuestAdditions.iso
