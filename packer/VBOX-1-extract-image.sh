#!/bin/bash -eux

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
#
########################################################################

SECONDS=0
echo " Start: " `date`

DEPLOYMENT_DIR=$1       #ex. $1=~/Development/deployment/vms/mm/devpaas
IMAGE_NAME=$2           #ex. $2=mm-base-ubuntu-server-1604  - omit extension .tar.gz
IMAGE_VERSION=$3        #ex. $3=0.0.1

echo "Deployment dir: $DEPLOYMENT_DIR"

if [ ! -d "$DEPLOYMENT_DIR" ]; then
  echo "Create dir: $DEPLOYMENT_DIR"
  mkdir -p $DEPLOYMENT_DIR/$IMAGE_NAME
fi

echo "****** Copy image $IMAGE_NAME/$IMAGE_NAME.tar.gz file into the deployment dir $DEPLOYMENT_DIR/ ******"
cp builds/$IMAGE_NAME/$IMAGE_NAME.tar.gz $DEPLOYMENT_DIR/

echo "****** Extract $IMAGE_NAME/$IMAGE_NAME.tar.gz file into the deployment dir ******"
if [ ! -d "$DEPLOYMENT_DIR/$IMAGE_NAME" ]; then
  echo "Create dir: $DEPLOYMENT_DIR/$IMAGE_NAME"
  mkdir -p $DEPLOYMENT_DIR/$IMAGE_NAME
fi

#cd $DEPLOYMENT_DIR/
echo "****** ls -al $DEPLOYMENT_DIR/"
ls -al $DEPLOYMENT_DIR/

echo "****** ls -al $DEPLOYMENT_DIR/$IMAGE_NAME"
ls -al $DEPLOYMENT_DIR/$IMAGE_NAME

echo "****** Extract the tar.gz in $DEPLOYMENT_DIR/$IMAGE_NAME dir ******"
tar -xvf $DEPLOYMENT_DIR/${IMAGE_NAME}.tar.gz -C $DEPLOYMENT_DIR/$IMAGE_NAME

echo "****** Delete tar.gz of deployed image ******"
rm -f $DEPLOYMENT_DIR/${IMAGE_NAME}.tar.gz


duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`