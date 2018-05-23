#!/bin/bash -eux

########################################################################
#
# title:          Build Ubuntu Image for DevPaas (Single Instance)
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas
# description:    Create image for DEVPAAS (Instance) server based on image
#
# to run:         sh build-image-devpaas-singleinstance-ubuntu.sh virtualbox-iso
#
########################################################################

SECONDS=0
echo " Start: " `date`
export PACKER_LOG=1

export PACKER_PROVIDERS_LIST=$1

export SSH_USERNAME=$2

export ATLAS_TOKEN=$3
export ATLAS_USERNAME=$4

export AWS_SSH_KEYPAIR_NAME=$5          #marcomaccio-eu-west-1
export AWS_SSH_PRIVATE_KEY_FILE=$6      #/Users/marcomaccio/.aws/marcomaccio-eu-west-1.pem
export AWS_REGION=$7
export AWS_SOURCE_IMAGE=$8
export AWS_INSTANCE_TYPE=$9
export AWS_VPC_ID=${10}
export AWS_SUBNET_ID=${11}

export GCP_PROJECT_ID=${12}
export GCP_ZONE=${13}
export GCP_SOURCE_IMAGE=${14}

cd packer

echo '****** Build marmac devpaas sonarqube x ubuntu-1604 image ******'
packer build -force -only=$PACKER_PROVIDERS_LIST        \
        -var "atlas_username=$ATLAS_USERNAME"           \
        -var "aws_ssh_keypair_name=$AWS_SSH_KEYPAIR_NAME"   \
        -var "aws_ssh_private_key_file=$AWS_SSH_PRIVATE_KEY_FILE"   \
        -var "aws_region=$AWS_REGION"                       \
        -var "aws_source_image=$AWS_SOURCE_IMAGE"           \
        -var "aws_instance_type=$AWS_INSTANCE_TYPE"         \
        -var "aws_vpc_id=$AWS_VPC_ID"                       \
        -var "aws_subnet_id=$AWS_SUBNET_ID"                 \
        -var "gcp_project_id=$GCP_PROJECT_ID"               \
        -var "gcp_zone=$GCP_ZONE"                           \
        -var "gcp_source_image=$GCP_SOURCE_IMAGE"           \
        -var "ssh_username=$SSH_USERNAME"           \
        templates/sonarqube/packer-sonarqube-ubuntu.json

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
