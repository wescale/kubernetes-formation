
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

1. Create the GSuite users on **training.wecontrol.cloud** domain and place them in *k8s-training-niv-1* group and *kube-niv-1* OU. For that, ask an admin on the suite Domain.
2. Create the target GCP projects. For this, see https://gitlab.com/wescalefr/bootstrap-gcp-kube-training.
 
## Get Terraform 

In version "~> 0.12"

## Get GCP credentials

Terraform needs to runs actions on GCP in folder *folders/795997944654* (belonging to wescale.fr domain).

Ask an admin to be set in the correct GSuite group.

## Run the wrapper script

Check the number of projects to be used in *tf-runner.sh* script.

If running for CND Kube training, add CND=true env variable.

Then:
```
bash tf-runner.sh provision

# If running for CND Kube training, add CND=true env variable.
bash CND=true tf-runner.sh provision
```

Outputs:
- config/ips : IP list of bastion machines
- config/adresses : DNS entries list of bastion machines
- config/users.csv : List of GCP users to create (optional: only if the GCP console has to be used)

## At the end of training, clean the GKE clusters


```
bash tf-runner.sh clean
```

## At the end of training, clean the Wecontrol users

Ask a domain admin on training.wecontrol.cloud
