#!/bin/bash -eux

################################################################################################
#
# title:          Build Base Image based on Ubuntu 16.04
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas
# description:    Create image for Base server based on Ubuntu 16.04 ISO image
#
# to run:
#           sh AWS-build-image-devpaas-base-ubuntu-server-1604.sh amazon-ebs                \
#                                                               AWS_SSH_USERNAME            \
#                                                               AWS_SSH_KEYPAIR_NAM         \
#                                                               AWS_SSH_PRIVATE_KEY_FILE    \
#                                                               AWS_REGIO                   \
#                                                               AWS_VPC_ID                  \
#                                                               AWS_SUBNET_ID               \
#                                                               AWS_SOURCE_IMAGE            \
#                                                               AWS_SOURCE_IMAGE            \
#                                                               AWS_INSTANCE_TYPE           \
#                                                               AWS_SECURITY_GROUPS
################################################################################################

SECONDS=0
echo " Start: " `date`

export PACKER_LOGS_FILENAME="AWS-packer-base-ubuntu-server-1604.log"

mkdir -p builds/packer_logs
echo "Verify if already exist the packer log file"
if [ -e ./builds/packer_logs/$PACKER_LOGS_FILENAME ]
then
    echo "Delete the log file of a previous run ..."
    rm -f ./builds/packer_logs/$PACKER_LOGS_FILENAME
fi

export PACKER_LOG=1
export PACKER_LOG_PATH="./builds/packer_logs/$PACKER_LOGS_FILENAME"

export PACKER_PROVIDERS_LIST=$1         # ex. amazone-ebs

export AWS_SSH_USERNAME=$2
export AWS_SSH_KEYPAIR_NAME=$3          # ex. accountId-iam_user-region
export AWS_SSH_PRIVATE_KEY_FILE=$4      # ex. ~/.aws/accountId-iam_user-region.pem
export AWS_REGION=$5                    # ex. eu-west-1
export AWS_VPC_ID=$6                    # ex. vpc-*****
export AWS_SUBNET_ID=$7                 # ex. subnet-*****
export AWS_SOURCE_IMAGE=$8              # ex. ami-****
export AWS_INSTANCE_TYPE=$9             # ex. t2.micro
export AWS_SECURITY_GROUPS=${10}        # ex. sg-*****

echo "Preparing build for $PACKER_PROVIDERS_LIST ..."
export PACKER_TEMPLATE=templates/packer-devpaas-base-ubuntu-server-1604.json

echo '****** Build marmac devpaas Base Ubuntu-1604 image ******'
packer validate -only=${PACKER_PROVIDERS_LIST}                      \
        -var "aws_ssh_username=$AWS_SSH_USERNAME"                   \
        -var "aws_ssh_keypair_name=$AWS_SSH_KEYPAIR_NAME"           \
        -var "aws_ssh_private_key_file=$AWS_SSH_PRIVATE_KEY_FILE"   \
        -var "aws_region=$AWS_REGION"                               \
        -var "aws_vpc_id=$AWS_VPC_ID"                               \
        -var "aws_subnet_id=$AWS_SUBNET_ID"                         \
        -var "aws_source_image=$AWS_SOURCE_IMAGE"                   \
        -var "aws_instance_type=$AWS_INSTANCE_TYPE"                 \
        -var "aws_security_groups=$AWS_SECURITY_GROUPS"             \
        ${PACKER_TEMPLATE}

packer build -force -only=${PACKER_PROVIDERS_LIST}                  \
        -var "aws_ssh_username=$AWS_SSH_USERNAME"                   \
        -var "aws_ssh_keypair_name=$AWS_SSH_KEYPAIR_NAME"           \
        -var "aws_ssh_private_key_file=$AWS_SSH_PRIVATE_KEY_FILE"   \
        -var "aws_region=$AWS_REGION"                               \
        -var "aws_vpc_id=$AWS_VPC_ID"                               \
        -var "aws_subnet_id=$AWS_SUBNET_ID"                         \
        -var "aws_source_image=$AWS_SOURCE_IMAGE"                   \
        -var "aws_instance_type=$AWS_INSTANCE_TYPE"                 \
        -var "aws_security_groups=$AWS_SECURITY_GROUPS"             \
        ${PACKER_TEMPLATE}

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
