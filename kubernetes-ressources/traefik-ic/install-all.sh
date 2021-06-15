#!/bin/bash

set -euo pipefail

username=$(gcloud config get-value account)

for i in `seq 0 11`;
do
        gcloud container clusters get-credentials "training-cluster-0" --zone europe-west1-b --project "wsc-kubernetes-training-$i"
        kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$username
        kubectl apply -f traefik-rbac.yaml
        #kubectl delete -f traefik-ds.yaml
        kubectl apply -f traefik-ds.yaml
        kubectl apply -f ../../Day-3/exercise-monitoring/rbac.yaml
done
