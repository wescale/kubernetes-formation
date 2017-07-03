#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    IFS=':'
    array=( $line )
    echo "instance = ${array[0]}"
    echo "ip = ${array[1]}"
    IFS=''

    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "sudo apt-get install -y nodejs npm" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "rm -Rf /home/training/prometheus" < /dev/null
    ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/prometheus" < /dev/null
    # ssh -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey training@${array[1]} "mkdir -p /home/training/exercice3-back" < /dev/null
    scp -r -i /Users/sebastienlavayssiere/Documents/Gemalto/gemalto.privkey ~/Documents/Gemalto/prometheus/* training@${array[1]}:/home/training/prometheus/
    echo "Done for ${array[0]}:$?"

done < "$1"

echo "Done"
