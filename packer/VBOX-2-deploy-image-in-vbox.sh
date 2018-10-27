#!/bin/bash -eux

########################################################################
#
# title:          Deploy a VirtualBox VM into Virtual Box
# author:         Marco Maccio (http://www.marmac.name)
# url:            http://github.com/marcomaccio/devpaas-vm
# description:    Deploy a VirtualBox VM (.mf/.ovf/.vmdk) into Virtual Box
#
# to run:
#                   sh deploy-devpaas-ubuntu-image.sh       \
#                           deployments                     \
#                           image_name                      \
#                           image_version                   \
#                           target_vm_name                  \
#                           host_only_network_name          \
#                           host_only_network_ip
#
########################################################################

SECONDS=0
echo " Start: " `date`

DEPLOYMENT_DIR=${1}             # ex. $1=~/Development/deployment/vms/mm/devpaas
IMAGE_NAME=${2}                 # ex. $2=mm-base-ubuntu-server-1604  - omit extension .tar.gz
IMAGE_VERSION=${3}              # ex. $3=0.0.1
TARGET_VM_NAME=${4}             # ex. $4=base-ubu-srv-1604
HOST_ONLY_NETWORK_NAME=${5}     # ex. $5="VirtualBox Host-Only Ethernet Adapter #2"
HOST_ONLY_NETWORK_IP=${6}       # ex. $6=192.168.1.10

echo "Deployment dir: ${DEPLOYMENT_DIR}"

echo "****** Import ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}/${TARGET_VM_NAME}.ovf file in Virtual Box ******"
ls -al ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}

vboxmanage import ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}/${TARGET_VM_NAME}.ovf

echo "****** List all the current VM in Virtual Box ******"
vboxmanage list vms

#echo "****** Modify Networking  ******"
#vboxmanage modifyvm $IMAGE_NAME-$IMAGE_VERSION --nic2 hostonly --hostonlyadapter2 ${HOST_ONLY_NETWORK_NAME} --cableconnected2 on
echo "****** Enable Symlink on shared directory ******"
VBoxManage setextradata ${TARGET_VM_NAME} VBoxInternal2/SharedFoldersEnableSymlinksCreate/data 1
VBoxManage getextradata ${TARGET_VM_NAME} enumerate

echo "****** Start the VM in Virtual Box ******"
vboxmanage startvm --type gui ${TARGET_VM_NAME}

echo "****** List all running VMs in Virtual Box ******"
vboxmanage list runningvms

echo "******************************************************************************"
echo "******************************************************************************"

echo "****** Show VM info for: ${TARGET_VM_NAME} in Virtual Box ******"
vboxmanage showvminfo ${TARGET_VM_NAME}

echo "******************************************************************************"
echo "******************************************************************************"



echo "**************************************************************************"
echo "TO POWER OFF: vboxmanage controlvm ${TARGET_VM_NAME} poweroff"
echo "**************************************************************************"

duration=${SECONDS}
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`