#!/bin/bash

list_ip=$(gcloud compute --project "sandbox-wescale" instances list --filter="name:training-instance*" --format="value(networkInterfaces[0].accessConfigs.natIP)")

echo $list_ip

index=0

for ip in $list_ip
do
    echo "ip = ${ip}"

    ssh -oStrictHostKeyChecking=no -i ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "curl -s https://raw.githubusercontent.com/WeScale/kubernetes-formation/master/kubernetes-ressources/terraform/modules/bootstrap-vm.sh | sudo bash -s ${index}"
    $index = $index +1

    ## Exercice 2
    # ssh -i  ./terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice2/" < /dev/null
    # scp -r -i ./terraform/kubernetes-formation ./exercice2/create.sh training@${ip}:~/exercice2/create.sh
    # ssh -i  ./terraform/kubernetes-formation training@${ip} "~/exercice2/create.sh" < /dev/null

    ## Exercice 3
    # ssh -i  ./terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice3/" < /dev/null
    # scp -r -i ./terraform/kubernetes-formation ./exercice3/front-test training@${ip}:~/exercice3
    # scp -r -i ./terraform/kubernetes-formation ./exercice3/webservice-test training@${ip}:~/exercice3

    ## Exercice 3 bis
    # scp -r -i ./terraform/kubernetes-formation ./exercice3/infra training@${ip}:~/exercice3
    # scp -r -i ./terraform/kubernetes-formation ./exercice3/traefik training@${ip}:~/exercice3

    ## demo Kubernetes
    # scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-kubernetes/webservice.yaml training@${ip}:~/

    ## Exercice 3 bis
    # scp -r -i ./terraform/kubernetes-formation ./get-token-dashboard.sh training@${ip}:~/


    ## Prometheus
    # ssh -i  ./kubernetes-ressources/terraform/kubernetes-formation ubuntu@${ip} "rm -f ~/prometheus/*" < /dev/null
    # scp -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-monitoring/grafana.yml ubuntu@${ip}:/home/ubuntu/prometheus
    # scp -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-monitoring/prometheus-deployment.yaml ubuntu@${ip}:/home/ubuntu/prometheus


    
    echo "Done for ${ip}"

done

echo "Done"
