#!/bin/bash

list_ip=$(gcloud compute --project "sandbox-wescale" instances list --filter="name:training-instance*" --format="value(networkInterfaces[0].accessConfigs.natIP)")

echo $list_ip

for ip in $list_ip
do
    echo "ip = ${ip}"
    
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "mkdir -p ~/helm/" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "chmod 700 get_helm.sh" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${ip} "./get_helm.sh" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${ip}:/home/training/prometheus/
    
    echo "Done for ${ip}"

done

echo "Done"
