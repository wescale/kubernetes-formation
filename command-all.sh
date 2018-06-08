#!/bin/bash

list_ip=$(gcloud compute --project "sandbox-wescale" instances list --filter="name:training-instance*" --format="value(networkInterfaces[0].accessConfigs.natIP)")

echo $list_ip

for ip in $list_ip
do
    echo "ip = ${ip}"
    
    ## Exercice 2
    #ssh -i  ./terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice2/" < /dev/null
    #scp -r -i ./terraform/kubernetes-formation ./exercice2/create.sh training@${ip}:~/exercice2/create.sh
    #ssh -i  ./terraform/kubernetes-formation training@${ip} "~/exercice2/create.sh" < /dev/null

    ## Exercice 3
    #ssh -i  ./terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice3/" < /dev/null
    #scp -r -i ./terraform/kubernetes-formation ./exercice3/front-test training@${ip}:~/exercice3
    #scp -r -i ./terraform/kubernetes-formation ./exercice3/webservice-test training@${ip}:~/exercice3

    ## Exercice 3 bis
    #scp -r -i ./terraform/kubernetes-formation ./exercice3/infra training@${ip}:~/exercice3
    #scp -r -i ./terraform/kubernetes-formation ./exercice3/traefik training@${ip}:~/exercice3


    ## Exercice 3 bis
    #scp -r -i ./terraform/kubernetes-formation ./get-token-dashboard.sh training@${ip}:~/


    ## Prometheus
    ssh -i  ./terraform/kubernetes-formation training@${ip} "mkdir -p ~/prometheus/" < /dev/null
    scp -r -i ./terraform/kubernetes-formation ./prometheus/* training@${ip}:/home/training/prometheus
    
    echo "Done for ${ip}"

done

echo "Done"
