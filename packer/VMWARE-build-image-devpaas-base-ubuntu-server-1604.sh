#!/bin/bash -eux

################################################################################################
#
# title:          Build NodeJS Image based on Ubuntu 16.04
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas-vm
# description:    Create image for NodeJS WebServer Image server based on Ubuntu 16.04 ISO image
#
# to run:
#           sh VMWARE-build-image-devpaas-base-ubuntu-server-1604.sh vmware-iso             \
#                                                               -debug                      \
#                                                               IMAGE_ISO_URL               \
#                                                               IMAGE_ISO_CHECKSUM          \
#                                                               IMAGE_ISO_CHECKSUM_TYPE     \
#                                                               IMAGE_OUTPUT_NAME           \
#                                                               IMAGE_OUTPUT_VERSION        \
#                                                               VBOX_SSH_USERNAME           \
#                                                               VBOX_SSH_PASSWORD           \
#                                                               VBOX_IMAGE_VERSION          \
#                                                               VBOX_VERSION                \
#                                                               VBOX_GUEST_ADDITIONS_URL    \
#                                                               VBOX_OVA_SOURCE_PATH
################################################################################################

SECONDS=0
echo " Start: " `date`

export PACKER_LOGS_FILENAME="VMWARE-packer-base-ubuntu-server-1604.log"

mkdir -p builds/packer_logs
echo "Verify if already exist the packer log file"
if [ -e ./builds/packer_logs/$PACKER_LOGS_FILENAME ]
then
    echo "Delete the log file of a previous run ..."
    rm -f ./builds/packer_logs/$PACKER_LOGS_FILENAME
fi

export PACKER_LOG=1
export PACKER_LOG_PATH="./builds/packer_logs/$PACKER_LOGS_FILENAME"

export PACKER_PROVIDERS_LIST=${1}       # ex. virtualbox-iso or virtualbox-ovf

export DEBUG=${2}                       # ex. -debug

export IMAGE_ISO_URL=${3}               # ex. http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso
export IMAGE_ISO_CHECKSUM=${4}          # ex. 0a03608988cfd2e50567990dc8be96fb3c501e198e2e6efcb846d89efc7b89f2
export IMAGE_ISO_CHECKSUM_TYPE=${5}     # ex. sha256
export IMAGE_OUTPUT_NAME=${6}           # ex. base-ubuntu-server-1604
export IMAGE_OUTPUT_VERSION=${7}        # ex. 0.0.1

export SSH_USER_FULL_NAME=${13}         # ex. Administrator
export SSH_USERNAME=${10}               # ex. packer
export SSH_PASSWORD=${11}               # ex. packer


export PRESEED_FILENAME=${14}           # ex. preseed-base-ubuntu-server-1604.cfg

export INSTANCE_VCPU=${15}              # ex. 2
export INSTANCE_MEMORY=${16}            # ex. 1024 = 1Gb
export INSTANCE_DOMAIN_NAME=${17}       # ex. domain-name.local

export INSTANCE_NAME="${IMAGE_OUTPUT_NAME}-${IMAGE_OUTPUT_VERSION}"
echo "$INSTANCE_NAME"

echo "Preparing build for $PACKER_PROVIDERS_LIST ..."
export PACKER_TEMPLATE=templates/packer-devpaas-base-ubuntu-server-1604.json

echo "Build the preseed file from the template ..."

sed "s/USER_FULL_NAME/${SSH_USER_FULL_NAME}/g; s/USER_USERNAME/${SSH_USERNAME}/g; s/USER_PASSWORD/${SSH_PASSWORD}/g" http/preseed-ubuntu-server-1604.template > http/$PRESEED_FILENAME

echo "Build the $IMAGE_OUTPUT_NAME v. $IMAGE_OUTPUT_VERSION using the packer template: $PACKER_TEMPLATE ..."

packer validate -only=${PACKER_PROVIDERS_LIST}                      \
        -var "image_iso_url=$IMAGE_ISO_URL"                         \
        -var "image_iso_checksum=$IMAGE_ISO_CHECKSUM"               \
        -var "image_iso_checksum_type=$IMAGE_ISO_CHECKSUM_TYPE"     \
        -var "image_output_name=$IMAGE_OUTPUT_NAME"                 \
        -var "image_output_version=$IMAGE_OUTPUT_VERSION"           \
        -var "instance_name=$INSTANCE_NAME"                         \
        -var "instance_domain_name=$INSTANCE_DOMAIN_NAME"           \
        -var "instance_vcpu=${INSTANCE_VCPU}"                       \
        -var "instance_memory=${INSTANCE_MEMORY}"                   \
        -var "vbox_ssh_username=$SSH_USERNAME"                      \
        -var "vbox_ssh_password=$SSH_PASSWORD"                      \
        -var "preseed_filename=$PRESEED_FILENAME"                   \
        ${PACKER_TEMPLATE}

packer build -force -only=${PACKER_PROVIDERS_LIST}  ${DEBUG}        \
        -var "image_iso_url=$IMAGE_ISO_URL"                         \
        -var "image_iso_checksum=$IMAGE_ISO_CHECKSUM"               \
        -var "image_iso_checksum_type=$IMAGE_ISO_CHECKSUM_TYPE"     \
        -var "image_output_name=$IMAGE_OUTPUT_NAME"                 \
        -var "image_output_version=$IMAGE_OUTPUT_VERSION"           \
        -var "instance_name=$INSTANCE_NAME"                         \
        -var "instance_domain_name=$INSTANCE_DOMAIN_NAME"           \
        -var "instance_vcpu=${INSTANCE_VCPU}"                       \
        -var "instance_memory=${INSTANCE_MEMORY}"                   \
        -var "vbox_ssh_username=$SSH_USERNAME"                      \
        -var "vbox_ssh_password=$SSH_PASSWORD"                      \
        -var "preseed_filename=$PRESEED_FILENAME"                   \
        ${PACKER_TEMPLATE}

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
