#!/bin/bash -eux

########################################################################
#
# title:          Build Ubuntu 17.04 Image for Base Image
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas
# description:    Create image for Base Image server based on image
#
# to run:         sh VBOX-build-image-devpaas-base-ubuntu-desktop-1704.sh virtualbox-iso        \
#                                                               -debug                          \
#                                                               ATLAS_USERNAME                  \
#                                                               ATLAS_TOKEN                     \
#                                                               VBOX_SSH_USERNAME               \
#                                                               VBOX_SSH_PASSWORD               \
#                                                               VBOX_IMAGE_VERSION              \
#                                                               VBOX_GUEST_ADDITIONS_PATH
#
########################################################################

SECONDS=0
echo " Start: " `date`
mkdir -p packer_logs
if [ -e ./packer_logs/VBOX-packer-devpass-base-ubuntu-desktop-1704.log ]
then
    echo "Delete the log file of a previous run ..."
    rm -f ./packer_logs/VBOX-packer-devpass-base-ubuntu-desktop-1704.log
fi

export PACKER_LOG=1
export PACKER_LOG_PATH="./packer_logs/VBOX-packer-devpass-base-ubuntu-desktop-1704.log"

export PACKER_PROVIDERS_LIST=$1

export DEBUG=$2

export ATLAS_USERNAME=$3
export ATLAS_TOKEN=$4

export VBOX_SSH_USERNAME=$5
export VBOX_SSH_PASSWORD=$6
export VBOX_IMAGE_VERSION=$7
export VBOX_GUEST_ADDITIONS_PATH=$8
export VBOX_OVA_SOURCE_PATH=$9

if [ $PACKER_PROVIDERS_LIST = "virtualbox-iso" ]
then
    export PACKER_TEMPLATE=packer-devpaas-base-ubuntu-desktop-17-04.json

elif [ $PACKER_PROVIDERS_LIST = "virtualbox-ovf" ]
then
    export PACKER_TEMPLATE=packer-devpaas-base-ubuntu-ova.json
fi

echo "Build the packer template: $PACKER_TEMPLATE ..."

echo '****** Build marmac devpaas single instance x ubuntu-1604 image ******'
packer build -force -only=$PACKER_PROVIDERS_LIST  $DEBUG            \
        -var "atlas_username=$ATLAS_USERNAME"                       \
        -var "atlas_token=$ATLAS_TOKEN"                             \
        -var "vbox_ssh_username=$VBOX_SSH_USERNAME"                 \
        -var "vbox_ssh_password=$VBOX_SSH_PASSWORD"                 \
        -var "image_version=$VBOX_IMAGE_VERSION"                    \
        -var "vbox_guest_additions_path=$VBOX_GUEST_ADDITIONS_PATH" \
        -var "vbox_ova_source_path=$VBOX_OVA_SOURCE_PATH"           \
        templates/$PACKER_TEMPLATE

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
