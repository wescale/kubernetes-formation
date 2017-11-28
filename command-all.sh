#!/bin/bash

list_ip=$(gcloud compute --project "sandbox-wescale" instances list --filter="name:training-instance*" --format="value(networkInterfaces[0].accessConfigs.natIP)")

echo $list_ip

for ip in $list_ip
do
    echo "ip = ${ip}"
    
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "rm -Rf ~/exercice3/" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p ~/exercice3/" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/exercice3/front-test training@${array[1]}:/home/training/exercice3
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/exercice3/webservice-test training@${array[1]}:/home/training/exercice3
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p ~/exercice3/" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/webservice.yaml training@${array[1]}:/home/training/exercice3/
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/exercice3/webservice-test/* training@${array[1]}:/home/training/exercice3/
    
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "rm -Rf /home/training/prometheus" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/prometheus" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/exercice3-back" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${array[1]}:/home/training/prometheus/
    echo "Done for ${ip}"

done

echo "Done"
