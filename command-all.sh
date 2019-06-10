#!/bin/bash

list_ip=$(gcloud compute --project "sandbox-wescale" instances list --filter="name:training-instance*" --format="value(networkInterfaces[0].accessConfigs.natIP)")

echo $list_ip

index=0

for ip in $list_ip
do
    echo "ip = ${ip}"

    #ssh -oStrictHostKeyChecking=no -i ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "curl -s https://raw.githubusercontent.com/WeScale/kubernetes-formation/master/kubernetes-ressources/terraform/modules/bootstrap-vm.sh | sudo bash -s ${index}"
    #ssh -oStrictHostKeyChecking=no -i ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "sudo chown -R training:training /home/training/.config/"

    let "index++"

    ## Exercice 2
     #ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice2/" < /dev/null
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice2/create.sh training@${ip}:~/exercice2/create.sh
            #ssh -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "~/exercice2/create.sh" < /dev/null

    ## Exercice 3
     #ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercice3/" < /dev/null
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice3/front-test training@${ip}:~/exercice3
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice3/webservice-test training@${ip}:~/exercice3

    ## Exercice 3 bis
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice3/infra training@${ip}:~/exercice3
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice3/traefik training@${ip}:~/exercice3

    ## demo Kubernetes
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-kubernetes/webservice.yaml training@${ip}:~/

    ## guestbook
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-guestbook-go training@${ip}:~/

    ## Prometheus
     ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "rm -rf ~/prometheus && mkdir -p ~/prometheus" < /dev/null
     scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-monitoring/grafana.yml training@${ip}:~/prometheus/
     scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercice-monitoring/prometheus-deployment.yaml training@${ip}:~/prometheus/


    
    echo "Done for ${ip}"

done

echo "Done"
