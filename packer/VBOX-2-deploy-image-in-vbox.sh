#!/bin/bash -eux

########################################################################
#
# title:          Deploy an image for MM DevPaas HeadEnd Component
# author:         Marco Maccio (http://www.marmac.name)
# url:            http://github.com/marcomaccio/devpaas-vm
# description:    Deploy a Packer image into a given directory
#
# to run:
#                   sh VBOX-2-deploy-image-in-vbox.sh       \
#                           deployments                     \
#                           image_name                      \
#                           image_version
#
########################################################################

SECONDS=0
echo " Start: " `date`

DEPLOYMENT_DIR=$1       #ex. $1=~/Development/deployment/vms/mm/devpaas
IMAGE_NAME=$2           #ex. $2=mm-base-ubuntu-server-1604  - omit extension .tar.gz
IMAGE_VERSION=$3        #ex. $3=0.0.1

echo "Deployment dir: ${DEPLOYMENT_DIR}"

echo "****** Import ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${IMAGE_NAME}-${IMAGE_VERSION}.ovf file in Virtual Box ******"
ls -al ${DEPLOYMENT_DIR}/${IMAGE_NAME}/

export VM_NAME=${IMAGE_NAME}-${IMAGE_VERSION}-$(($RANDOM%100))
echo "New VM Name:  ${VM_NAME}"
vboxmanage import ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${IMAGE_NAME}-${IMAGE_VERSION}.ovf --vsys 0 --vmname ${VM_NAME}

echo "****** List all the VM in Virtual Box ******"
vboxmanage list vms

echo "****** Enable symlinks in VM shared Folder ******"
VBoxManage setextradata ${VM_NAME} VBoxInternal2/SharedFoldersEnableSymlinksCreate/data 1

echo "****** Start the VM in Virtual Box ******"
vboxmanage startvm --type gui ${VM_NAME}

echo "****** List all running VMs in Virtual Box ******"
vboxmanage list runningvms

echo "******************************************************************************"
echo "******************************************************************************"

echo "****** Show VM info for: ${VM_NAME} in Virtual Box ******"
vboxmanage showvminfo ${VM_NAME}

echo "******************************************************************************"
echo "******************************************************************************"



echo "**************************************************************************"
echo "TO POWER OFF: vboxmanage controlvm ${VM_NAME} poweroff"
echo "**************************************************************************"

duration=${SECONDS}
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`