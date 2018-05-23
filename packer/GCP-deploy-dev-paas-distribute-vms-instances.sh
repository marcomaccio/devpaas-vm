#!/bin/sh
# script call example:
#   ./GCP-deploy-dev-paas-distribute-vms-instances.sh [plan|apply|destroy] <gcp_projectid> <gcp_region> <gcp_imageId> <gcp_machine_type>
# echo $GOOGLE_ACCOUNT_FILE="<path_to_gcloud_json>"  (DEPRECATED)
# export GOOGLE_CLOUD_KEYFILE_JSON="<path_to_gcloud_json>"
# ex. ./GCP-deploy-dev-paas-distribute-vms-instances.sh plan my-devpaas europe-west1 mm-jenkins-2-v20161102 n1-standard-1

#TF_VAR_project_id=$1          \
#TF_VAR_region=$2              \
#TF_VAR_jenkins_image_name=$3  \
#TF_VAR_machine_type=$4
terraform $1  -var "project_id=$2"            \
              -var "region=$3"                \
              -var "jenkins_image_name=$4"    \
              -var "machine_type=$5"          \
              providers/googlecompute/devpaas-single-vm
