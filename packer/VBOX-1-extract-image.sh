#!/bin/bash -eu

########################################################################
#
# title:          Extract a Packer image from a tar.gz file created by packer
# author:         Marco Maccio (http://www.marmac.name)
# url:            http://github.com/marcomaccio/devpaas-vm
# description:    Extract a Packer image from a tar.gz into a given directory
#
# to run:
#                   sh VBOX-1-deploy-image-in-vbox.sh       \
#                           deployments                     \
#                           image_name                      \
#                           image_version
#                           target_vm_name
#
########################################################################

SECONDS=0
echo " Start: " `date`

DEPLOYMENT_ROOT_DIR=${1}  # ex. $1=deployments
IMAGE_NAME=${2}           # ex. $2=mm-base-ubuntu-server-1604  - omit extension .tar.gz
IMAGE_VERSION=${3}        # ex. $3=0.0.1
TARGET_VM_NAME=${4}       # ex. $4=base-ubu-srv-1604

echo "Deployment dir: ${DEPLOYMENT_ROOT_DIR}"

#if [ ! -d "${DEPLOYMENT_ROOT_DIR}" ]; then
  echo "Create dir: ${DEPLOYMENT_ROOT_DIR}"
  mkdir -p ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}
#fi

echo "****** Copy image ${IMAGE_NAME}/${IMAGE_NAME}.tar.gz file into the deployment dir ${DEPLOYMENT_ROOT_DIR}/ ******"
cp builds/${IMAGE_NAME}/${IMAGE_NAME}.tar.gz ${DEPLOYMENT_ROOT_DIR}/

#cd $DEPLOYMENT_DIR/
echo "****** ls -al ${DEPLOYMENT_ROOT_DIR}/"
ls -al ${DEPLOYMENT_ROOT_DIR}/

echo "****** ls -al ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}"
ls -al ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}

echo "****** ls -al ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}"
ls -al ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}

echo "****** Extract the tar.gz in $DEPLOYMENT_ROOT_DIR/$IMAGE_NAME dir ******"
tar -xvf ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}.tar.gz -C ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}

echo "****** Delete tar.gz of deployed image ******"
rm -f ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}.tar.gz

cd ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${TARGET_VM_NAME}

echo "****** Change the virtual disk filename from ${IMAGE_NAME}-${IMAGE_VERSION}-disk001.vmdk to ${TARGET_VM_NAME}-disk001.vmdk"
mv ${IMAGE_NAME}-${IMAGE_VERSION}-disk001.vmdk ${TARGET_VM_NAME}-disk001.vmdk

#echo "****** Modify MF VBOX Files: ${DEPLOYMENT_DIR}/${IMAGE_NAME}/${IMAGE_NAME}-${IMAGE_VERSION}.mf file  ******"
#sed -i "s/${IMAGE_NAME}-${IMAGE_VERSION}/${TARGET_VM_NAME}/g" ${IMAGE_NAME}-${IMAGE_VERSION}.mf

#echo "****** Change the manifest filename from ${IMAGE_NAME}-${IMAGE_VERSION}.mf to ${TARGET_VM_NAME}.mf"
#mv ${IMAGE_NAME}-${IMAGE_VERSION}.mf ${TARGET_VM_NAME}.mf

echo "****** Change the manifest filename ${IMAGE_NAME}-${IMAGE_VERSION}.mf has the sha256 has changed changing the .ovf"
rm -f mv ${IMAGE_NAME}-${IMAGE_VERSION}.mf

echo "****** Modify OVF VBOX Files: ${DEPLOYMENT_ROOT_DIR}/${IMAGE_NAME}/${IMAGE_NAME}-${IMAGE_VERSION}.ovf file  ******"
sed -i "s/${IMAGE_NAME}-${IMAGE_VERSION}/${TARGET_VM_NAME}/g" ${IMAGE_NAME}-${IMAGE_VERSION}.ovf

echo "****** Change the manifest filename from ${IMAGE_NAME}-${IMAGE_VERSION}.ovf to ${TARGET_VM_NAME}.ovf"
mv ${IMAGE_NAME}-${IMAGE_VERSION}.ovf ${TARGET_VM_NAME}.ovf

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`