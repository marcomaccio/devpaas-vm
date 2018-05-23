#!/bin/bash -eux

########################################################################
#
# title:          Build Ubuntu Image for Nexus 3 (Single Instance)
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas
# description:    Create image for Base Image server based on image
#
# to run:         sh AWS-build-image-devpaas-nexus3-ubuntu.sh amazon-ebs \
#
########################################################################

SECONDS=0
echo " Start: " `date`
mkdir -p packer_logs

if [ -e ./packer_logs/AWS-packer-nexus3-ubuntu.log ]
then
    echo "Delete the log file of a previous run ..."
    rm -f ./packer_logs/AWS-packer-nexus3-ubuntu.log
fi

export PACKER_LOG=1
export PACKER_LOG_PATH="./packer_logs/AWS-packer-nexus3-ubuntu.log"

export PACKER_PROVIDERS_LIST=$1

export AWS_SSH_USERNAME=$2
export AWS_SSH_KEYPAIR_NAME=$3          #marcomaccio-eu-west-1
export AWS_SSH_PRIVATE_KEY_FILE=$4      #/Users/marcomaccio/.aws/marcomaccio-eu-west-1.pem
export AWS_REGION=$5
export AWS_VPC_ID=$6
export AWS_SUBNET_ID=$7
export AWS_SOURCE_IMAGE=$8
export AWS_INSTANCE_TYPE=$9
export AWS_SECURITY_GROUPS=${10}

echo '****** Build marmac devpaas Nexus3 x ubuntu-1604 image ******'
packer build -force -only=$PACKER_PROVIDERS_LIST                    \
        -var "aws_ssh_username=$AWS_SSH_USERNAME"                   \
        -var "aws_ssh_keypair_name=$AWS_SSH_KEYPAIR_NAME"           \
        -var "aws_ssh_private_key_file=$AWS_SSH_PRIVATE_KEY_FILE"   \
        -var "aws_region=$AWS_REGION"                               \
        -var "aws_vpc_id=$AWS_VPC_ID"                               \
        -var "aws_subnet_id=$AWS_SUBNET_ID"                         \
        -var "aws_source_image=$AWS_SOURCE_IMAGE"                   \
        -var "aws_instance_type=$AWS_INSTANCE_TYPE"                 \
        -var "aws_security_groups=$AWS_SECURITY_GROUPS"             \
        templates/nexus/packer-nexus3-ubuntu.json

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`