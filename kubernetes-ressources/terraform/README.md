
The idea is to get an array of GKE cluster + bastion instance.

Each element of the array is deployed in a dedicated GCP project wsc-kubernetes-training-X.

To achieve this, we create a terraform workspace per element.


# Provisioned elements

* A GKE cluster with 3 nodes.
* A Compute Engine instance with a public IP to reach the cluster.
* A network 'training-net'
* A network 'training-subnet'
* A firewall to allow icmp/udp/tcp

# How to use it?

## Pre-requisites

1. Create the GSuite users on **training.wecontrol.cloud** domain and place them in *k8s-training-niv-1* group and *kube-niv-1* OU.
2. Create the target GCP projects. For this, see https://gitlab.com/wescalefr/bootstrap-gcp-kube-training.
 
## Get Terraform 

In version "~> 0.12"

## Get GCP credentials

Terraform needs to runs actions on GCP in folder *folders/795997944654* (belonging to wescale.fr domain).

The simplest way is to get a GCP service account key file in JSON format:
* as Wescale.fr user, connect on [GCP/IAM/Service accounts](https://console.cloud.google.com/iam-admin/serviceaccounts?folder=&orgonly=true&project=wsc-training-deploy).
* select tf-deploy and click on *create key*
* export the downloaded file: `export GOOGLE_CREDENTIALS=PATH_TO_KEY.json`

## Run the wrapper script

Check the number of projects to be used in *tf-runner.sh* script.

Then:
```
bash tf-runner.sh provision
```

## Clean
```
bash tf-runner.sh clean
```
