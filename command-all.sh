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
     #ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercise2/" < /dev/null
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise2/create.sh training@${ip}:~/exercise2/create.sh
            #ssh -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "~/exercise2/create.sh" < /dev/null

    ## Exercice 3
     #ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "mkdir -p ~/exercise3/" < /dev/null
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise3/front-test training@${ip}:~/exercise3
     #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise3/webservice-test training@${ip}:~/exercise3

    ## Exercice 3 bis
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise3/infra training@${ip}:~/exercise3
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise3/traefik training@${ip}:~/exercise3

    ## demo Kubernetes
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise-kubernetes/webservice.yaml training@${ip}:~/

    ## guestbook
    #scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise-guestbook-go training@${ip}:~/

    ## Prometheus
     ssh -oStrictHostKeyChecking=no -i  ./kubernetes-ressources/terraform/kubernetes-formation training@${ip} "rm -rf ~/prometheus && mkdir -p ~/prometheus" < /dev/null
     scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise-monitoring/grafana.yml training@${ip}:~/prometheus/
     scp -oStrictHostKeyChecking=no -r -i ./kubernetes-ressources/terraform/kubernetes-formation ./exercise-monitoring/prometheus-deployment.yaml training@${ip}:~/prometheus/


    
    echo "Done for ${ip}"

done

echo "Done"
