#!/bin/bash -eux

########################################################################
#
# title:          Build Ubuntu Image for DevPaas (Single Instance)
# author:         Marco Maccio (http://marmac.name)
# url:            https://github.com/marcomaccio/devpaas
# description:    Create image for DEVPAAS (Instance) server based on image
#
# to run:         sh GCP-build-image-nexus2-ubuntu.sh googlecompute
#
########################################################################

SECONDS=0
echo " Start: " `date`
export PACKER_LOG=1

export PACKER_PROVIDERS_LIST=$1

export DEBUG=$2

export GCP_ACCOUNT_FILE=$3
export GCP_PROJECT_ID=$4
export GCP_ZONE=$5
export GCP_SOURCE_IMAGE=$6
export GCP_SSH_USERNAME=$7

echo '****** Build marmac devpaas single instance x ubuntu-1604 image ******'
packer build -force -only=$PACKER_PROVIDERS_LIST  $DEBUG            \
        -var "gcp_account_file=$GCP_ACCOUNT_FILE"                   \
        -var "gcp_project_id=$GCP_PROJECT_ID"                       \
        -var "gcp_zone=$GCP_ZONE"                                   \
        -var "gcp_source_image=$GCP_SOURCE_IMAGE"                   \
        -var "gcp_ssh_username=$GCP_SSH_USERNAME"                   \
        templates/nexus/packer-nexus2-ubuntu.json

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo " End: " `date`
