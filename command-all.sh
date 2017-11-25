#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    IFS=':'
    array=( $line )
    echo "instance = ${array[0]}"
    echo "ip = ${array[1]}"
    IFS=''

    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p ~/prometheus/" < /dev/null
    scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${array[1]}:/home/training/prometheus
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p ~/exercice3/" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/webservice.yaml training@${array[1]}:/home/training/exercice3/
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/exercice3/webservice-test/* training@${array[1]}:/home/training/exercice3/
    
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "rm -Rf /home/training/prometheus" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/prometheus" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/exercice3-back" < /dev/null
    # scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${array[1]}:/home/training/prometheus/
    echo "Done for ${array[0]}:$?"

done < "$1"

echo "Done"
