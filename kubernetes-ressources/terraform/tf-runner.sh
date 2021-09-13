#!/bin/bash

set -e

NB_PROJECTS=12 # can go to the value defined in https://gitlab.com/wescalefr/bootstrap-gcp-kube-training

OPT=$1   # option

ROOT_DIR=$(pwd)

function provision(){
  local project_id=0
  rm -rf "${ROOT_DIR}/config/ips"
  echo "First Name [Required],Last Name [Required],Email Address [Required],Password [Required],Password Hash Function [UPLOAD ONLY],Org Unit Path [Required]" > "${ROOT_DIR}/config/users.csv"
  echo "Group Email [Required],Member Email,Member Type,Member Role" > "${ROOT_DIR}/config/users_group.csv"

  while [ $project_id -lt $NB_PROJECTS ];do
    echo "Create content for project ${project_id}"
    set +e
    terraform workspace new "wsc-kubernetes-training-${project_id}"
    set -e
    terraform workspace select "wsc-kubernetes-training-${project_id}"
    terraform apply -auto-approve

    terraform output -json bastion_ip |jq -r . >> "${ROOT_DIR}/config/ips"
    userid=$(printf "%02d" "$project_id") # 2 digits, e.g. 01 for project 1
    passwd=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20) # 20 alpha-numeric chars
    echo "trainee${userid},trainee${userid},trainee${userid}@training.wecontrol.cloud,${passwd},,/kube-niv1-trainee" >> "${ROOT_DIR}/config/users.csv"
    echo "k8s-training-niv-1@training.wecontrol.cloud,trainee${userid}@training.wecontrol.cloud,USER,MEMBER" >> "${ROOT_DIR}/config/users_group.csv"
    project_id=$[$project_id+1]
  done
}

function clean() {
  local project_id=0
  while [ $project_id -lt $NB_PROJECTS ];do
    echo "Destroy content of project ${project_id}"
    set +e
    terraform workspace new "wsc-kubernetes-training-${project_id}"
    set -e
    terraform workspace select "wsc-kubernetes-training-${project_id}"
    terraform destroy -auto-approve
    terraform workspace select "default"
    terraform workspace delete "wsc-kubernetes-training-${project_id}"
    project_id=$[$project_id+1]
  done
}

terraform init -get

case $OPT in
   "provision") provision;;
   "clean") clean;;
   *)
    echo "Bad argument!"
    echo "Usage: \`$0 provision\` or \`$0 clean\`"
    exit 1
    ;;
esac
