#!/bin/bash -eux

########################################################################
#
# title:          Deploy an image for MM DevPaas HeadEnd Component
# author:         Marco Maccio (http://www.marmac.name)
# url:            http://github.com/marcomaccio/devpaas
# description:    Deploy DEVPAAS server as Virtual Box VM
#
# to run:
#                   sh VBOX-3-undeploy-image-in-vbox.sh     \
#                           image_name                      \
#                           image_version                   \
#                           vm_name
#
########################################################################

SECONDS=0
echo " Start: " `date`
DEPLOYMENT_DIR=${1}         # ex. $1=deployment
IMAGE_NAME=${2}             # ex. $2=mm-base-ubuntu-server-1604  - omit extension .tar.gz
IMAGE_VERSION=${3}          # ex. $3=0.0.1
VM_NAME=${4}                # ex. $4=base-ubu-srv-XX where XX is a random number 0 < XX < 100

echo "****** List all the VM in Virtual Box ******"
vboxmanage list vms

echo "****** List all running VMs in Virtual Box ******"
vboxmanage list runningvms

echo "****** Show VM info for: ${VM_NAME} in Virtual Box ******"
vboxmanage showvminfo ${VM_NAME}

echo "****** Stop the VM: ${VM_NAME} in Virtual Box ******"
vboxmanage controlvm ${VM_NAME} poweroff
sleep 10s

echo "****** Unregister the VM: ${VM_NAME} in Virtual Box and delete all its files ******"
vboxmanage unregistervm ${VM_NAME} --delete

echo "****** Delete deployment dir ${DEPLOYMENT_DIR}/${IMAGE_NAME} ******"
rm -rf ${DEPLOYMENT_DIR}/${IMAGE_NAME}

echo "****** Delete deployed tar.gz file: ${DEPLOYMENT_DIR}/${IMAGE_NAME} ******"
rm -f ${DEPLOYMENT_DIR}/${IMAGE_NAME}.tar.gz

duration=${SECONDS}
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`