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
    scp -r -i ./terraform/kubernetes-formation ./exercice3/infra training@${ip}:~/exercice3
    scp -r -i ./terraform/kubernetes-formation ./exercice3/traefik training@${ip}:~/exercice3

    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "chmod 700 get_helm.sh" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "./get_helm.sh" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${ip}:/home/training/prometheus/
    # scp -r -i ./terraform/kubernetes-formation ./webservice.yaml training@${ip}:/home/training/
    # scp -r -i ./terraform/kubernetes-formation ./dashboard.yaml training@${ip}:/home/training/
    # scp -r -i ./terraform/kubernetes-formation ./get-token-dashboard.sh training@${ip}:/home/training/
    # scp -r -i ./terraform/kubernetes-formation ./prometheus/* training@${ip}:/home/training/prometheus
    
    echo "Done for ${ip}"

done

echo "Done"
