#!/bin/bash -e

echo "***************************************************"
echo "***** Start network configuration for UBUNTU  *****"

echo "***** Add current user to vboxsf group  *****"
sudo usermod -G vboxsf -a ${USER_USERNAME}

#echo "***** Copy network configuration  *****"
#sudo cp /tmp/ubuntu/configs/etc-network-interfaces /etc/network/interfaces

#/etc/init.d/networking stop; /etc/init.d/networking start;


#echo "***** Copy resolv.conf  *****"
#cp /tmp/ubuntu/configs/etc-resolv.conf /etc/resolv.conf

#echo "***** Copy hosts  *****"
sudo cp /tmp/ubuntu/configs/etc-hosts-${IMAGE_INSTANCE_NAME} /etc/hosts

echo "***** End network configuration for UBUNTU  *****"
echo "*************************************************"