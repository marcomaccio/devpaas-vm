#!/bin/bash -eux

################################################################################################
#
# title:          Build Base Image based on Ubuntu 16.04
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas-vm
# description:    Create image for Base Image server based on Ubuntu 16.04 ISO image
#
# to run:
#           sh VBOX-build-image-devpaas-base-ubuntu-server-1604.sh virtualbox-iso           \
#                                                               -debug                      \
#                                                               IMAGE_ISO_URL               \
#                                                               IMAGE_ISO_CHECKSUM          \
#                                                               IMAGE_ISO_CHECKSUM_TYPE     \
#                                                               IMAGE_OUTPUT_NAME           \
#                                                               IMAGE_OUTPUT_VERSION        \
#                                                               VBOX_VERSION                \
#                                                               VBOX_GUEST_ADDITIONS_URL    \
#                                                               VBOX_SSH_USER_FULL_NAME     \
#                                                               VBOX_SSH_USERNAME           \
#                                                               VBOX_SSH_PASSWORD           \
#                                                               VBOX_OVA_SOURCE_PATH        \
#                                                               PRESEED_FILENAME            \
#                                                               INSTANCE_VCPU               \
#                                                               INSTANCE_MEMORY             \
#                                                               INSTANCE_DOMAIN_NAME
################################################################################################

SECONDS=0
echo " Start: " `date`

export PACKER_LOGS_FILENAME="VBOX-packer-base-ubuntu-server-1604.log"

mkdir -p builds/packer_logs
echo "Verify if already exist the packer log file"
if [ -e ./builds/packer_logs/$PACKER_LOGS_FILENAME ]
then
    echo "Delete the log file of a previous run ..."
    rm -f ./builds/packer_logs/$PACKER_LOGS_FILENAME
fi

export PACKER_LOG=1
export PACKER_LOG_PATH="./builds/packer_logs/$PACKER_LOGS_FILENAME"

export PACKER_PROVIDERS_LIST=${1}           # ex. virtualbox-iso or virtualbox-ovf

export DEBUG=${2}                           # ex. -debug

export IMAGE_ISO_URL=${3}                   # ex. http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso
export IMAGE_ISO_CHECKSUM=${4}              # ex. 0a03608988cfd2e50567990dc8be96fb3c501e198e2e6efcb846d89efc7b89f2
export IMAGE_ISO_CHECKSUM_TYPE=${5}         # ex. sha256
export IMAGE_OUTPUT_NAME=${6}               # ex. base-ubuntu-server-1604
export IMAGE_OUTPUT_VERSION=${7}            # ex. 0.0.1

export VBOX_VERSION=${8}                    # ex. 5.2.8
export VBOX_GUEST_ADDITIONS_URL=${9}        # ex. https://download.virtualbox.org/virtualbox/5.2.8/VBoxGuestAdditions_5.2.8.iso
export VBOX_DISK_SIZE=${10}                 # ex. 92160 = 90 Gb
export VBOX_SSH_USER_FULL_NAME=${11}        # ex. Administrator
export VBOX_SSH_USERNAME=${12}              # ex. packer
export VBOX_SSH_PASSWORD=${13}              # ex. packer
export VBOX_SHARED_FOLDER_ROOT_PATH=${14}   # ex. /c/deployments
export VBOX_OVA_SOURCE_PATH=${15}           # ex. deployment/mm-base-ubuntu-1604-0.0.1/mm-base-ubuntu-1604-0.0.1.ovf

export PRESEED_FILENAME=${16}               # ex. preseed-base-ubuntu-server-1604.cfg

export INSTANCE_VCPU=${17}                  # ex. 2
export INSTANCE_MEMORY=${18}                # ex. 1024 = 1Gb
export INSTANCE_DOMAIN_NAME=${19}           # ex. domain-name.local

export INSTANCE_NAME="${IMAGE_OUTPUT_NAME}-${IMAGE_OUTPUT_VERSION}"
echo "$INSTANCE_NAME"

echo "Preparing build for $PACKER_PROVIDERS_LIST ..."
export PACKER_TEMPLATE=templates/packer-devpaas-base-ubuntu-server-1604.json

echo "Build the preseed file from the template ..."

echo "Create the preseed ${PRESEED_FILENAME} file from the template ..."
sed "s/HOST_NAME/${INSTANCE_NAME}/g; s/DOMAIN_NAME/${INSTANCE_DOMAIN_NAME}/g" http/preseed-ubuntu-server-1604.template > http/${PRESEED_FILENAME}
sed "s/USER_FULL_NAME/${VBOX_SSH_USER_FULL_NAME}/g; s/USER_USERNAME/${VBOX_SSH_USERNAME}/g; s/USER_PASSWORD/${VBOX_SSH_PASSWORD}/g" http/preseed-ubuntu-server-1604.template > http/${PRESEED_FILENAME}

echo "Preconfigure the /etc/hosts file file from the template ..."
sed "s/HOST_NAME/${INSTANCE_NAME}/g; s/DOMAIN_NAME/${INSTANCE_DOMAIN_NAME}/g" resources/ubuntu/configs/etc-hosts.template > resources/ubuntu/configs/etc-hosts-${INSTANCE_NAME}

echo "Build the $IMAGE_OUTPUT_NAME v. $IMAGE_OUTPUT_VERSION using the packer template: $PACKER_TEMPLATE ..."

packer validate -only=${PACKER_PROVIDERS_LIST}                              \
        -var "image_iso_url=${IMAGE_ISO_URL}"                               \
        -var "image_iso_checksum=${IMAGE_ISO_CHECKSUM}"                     \
        -var "image_iso_checksum_type=${IMAGE_ISO_CHECKSUM_TYPE}"           \
        -var "image_output_name=${IMAGE_OUTPUT_NAME}"                       \
        -var "image_output_version=${IMAGE_OUTPUT_VERSION}"                 \
        -var "instance_name=${INSTANCE_NAME}"                               \
        -var "instance_domain_name=${INSTANCE_DOMAIN_NAME}"                 \
        -var "instance_vcpu=${INSTANCE_VCPU}"                               \
        -var "instance_memory=${INSTANCE_MEMORY}"                           \
        -var "vbox_version=${VBOX_VERSION}"                                 \
        -var "vbox_guest_additions_url=${VBOX_GUEST_ADDITIONS_URL}"         \
        -var "vbox_disk_size=${VBOX_DISK_SIZE}"                             \
        -var "vbox_ssh_username=${VBOX_SSH_USERNAME}"                       \
        -var "vbox_ssh_password=${VBOX_SSH_PASSWORD}"                       \
        -var "vbox_ova_source_path=${VBOX_OVA_SOURCE_PATH}"                 \
        -var "vbox_shared_folder_root_path=${VBOX_SHARED_FOLDER_ROOT_PATH}" \
        -var "preseed_filename=${PRESEED_FILENAME}"                         \
        ${PACKER_TEMPLATE}

packer build -force -on-error=abort -only=${PACKER_PROVIDERS_LIST}  ${DEBUG}    \
        -var "image_iso_url=${IMAGE_ISO_URL}"                               \
        -var "image_iso_checksum=${IMAGE_ISO_CHECKSUM}"                     \
        -var "image_iso_checksum_type=${IMAGE_ISO_CHECKSUM_TYPE}"           \
        -var "image_output_name=${IMAGE_OUTPUT_NAME}"                       \
        -var "image_output_version=${IMAGE_OUTPUT_VERSION}"                 \
        -var "instance_name=${INSTANCE_NAME}"                               \
        -var "instance_domain_name=${INSTANCE_DOMAIN_NAME}"                 \
        -var "instance_vcpu=${INSTANCE_VCPU}"                               \
        -var "instance_memory=${INSTANCE_MEMORY}"                           \
        -var "vbox_version=${VBOX_VERSION}"                                 \
        -var "vbox_guest_additions_url=${VBOX_GUEST_ADDITIONS_URL}"         \
        -var "vbox_disk_size=${VBOX_DISK_SIZE}"                             \
        -var "vbox_ssh_username=${VBOX_SSH_USERNAME}"                       \
        -var "vbox_ssh_password=${VBOX_SSH_PASSWORD}"                       \
        -var "vbox_ova_source_path=${VBOX_OVA_SOURCE_PATH}"                 \
        -var "vbox_shared_folder_root_path=${VBOX_SHARED_FOLDER_ROOT_PATH}" \
        -var "preseed_filename=${PRESEED_FILENAME}"                         \
        ${PACKER_TEMPLATE}

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
