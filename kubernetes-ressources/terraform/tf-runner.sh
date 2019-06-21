#!/bin/bash

set -e

NB_PROJECTS=5 # can go to the value defined in https://gitlab.com/wescalefr/bootstrap-gcp-kube-training

OPT=$1   # option

function provision(){
  local project_id=1
  while [ $project_id -lt $NB_PROJECTS ];do
    echo "Create content for project ${project_id}"
    set +e
    terraform workspace new "wsc-kubernetes-training-${project_id}"
    set -e
    terraform workspace select "wsc-kubernetes-training-${project_id}"
    terraform apply
    project_id=$[$project_id+1]
  done
}

function clean() {
  local project_id=1
  while [ $project_id -lt $NB_PROJECTS ];do
    echo "Destroy content of project ${project_id}"
    set +e
    terraform workspace new "wsc-kubernetes-training-${project_id}"
    set -e
    terraform workspace select "wsc-kubernetes-training-${project_id}"
    terraform destroy
    terraform workspace select "default"
    terraform workspace delete "wsc-kubernetes-training-${project_id}"
    project_id=$[$project_id+1]
  done
}


case $OPT in
   "provision") provision;;
   "clean") clean;;
   *)
    echo "Bad argument!"
    echo "Usage: \`$0 provision\` or \`$0 clean\`"
    exit 1
    ;;
esac
