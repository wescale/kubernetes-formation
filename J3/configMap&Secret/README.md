# Creation du secret MYSQL_ROOT_PASSWORD
```
echo -n 'KubernetesTraining!' | base64
```
# Creation du secret mariadb-root-password 

Une fois le password rajouté:
```
kubectl apply -f mysql-secret.yaml
```

# Voir si tout c'est bien passé
```
kubectl describe secret mariadb-root-password
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}'
```
# Creation secret pour le user ( Deuxieme méthode de creation de secret)
```
kubectl create secret generic mariadb-user-creds \
      --from-literal=MYSQL_USER=kubeuser\
      --from-literal=MYSQL_PASSWORD=KubernetesTraining
```
# Vérifiez  que tout est bien crée

# Création de configMap
```
kubectl create configmap mariadb-config --from-file=max_allowed_packet.cnf
```
# Validation que tout est bien passé:
```
kubectl get configmap mariadb-config
```
# Editer la configMap pour changer la valeur max_allowed_packet à 32M
# Consulter le contenur du ConfigMap
```
kubectl get configmap mariadb-config -o yaml
```
# Utilisation du secret et configMap
# Rajouter les deux secret au Deployment comme variable d'environnement:

mariadb-root-password (avec une paire key/value)
mariadb-user-creds (avec deux paires key/value)
Les deux éléments à rajouter dans deployment:
```
env:
   - name: MYSQL_ROOT_PASSWORD
     valueFrom:
       secretKeyRef:
         name: mariadb-root-password
         key: password
```
et
```
envFrom:
- secretRef:
    name: mariadb-user-creds
```

Vous pouvez ajouter votre ConfigMap comme source, en l'ajoutant aux volumes et ensuite en ajoutant un volumeMount à la définition du conteneur :

# Rajouter votre configMap au deployment et le positionner au niveau du /etc/mysql/conf.d comme un volumeMount.

```
<...>

  volumeMounts:
  - mountPath: /var/lib/mysql
    name: mariadb-volume-1
  - mountPath: /etc/mysql/conf.d
    name: mariadb-config

<...>

volumes:
- emptyDir: {}
  name: mariadb-volume-1
- configMap:
    name: mariadb-config
    items:
      - key: max_allowed_packet.cnf
        path: max_allowed_packet.cnf
  name: mariadb-config-volume

<...>

```
# Creation de l'instanec MariaDB
```
kubectl create -f mariadb-deployment.yaml
```
# Verifier que l'instance utilise les Secrets et ConfigMap
```
kubectl exec -it [pod-id] env |grep MYSQL
kubectl exec -it [pod-id] ls /etc/mysql/conf.d

kubectl exec -it [pod-id] cat /etc/mysql/conf.d/max_allowed_packet.cnf
```

# Verification du fonctionnement
```
kubectl exec -it [pod-id] bin/sh

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e 'show databases;'
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SHOW VARIABLES LIKE 'max_allowed_packet';"
```

# Nettoyage
```
kubectl delete deployment mariadb-deployment
kubectl delete cm mariadb-config
kubectl delete secret mariadb-root-password mariadb-user-creds
```




