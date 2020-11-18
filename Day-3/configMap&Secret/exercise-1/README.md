# exercise-1: A secret and a configmap for a database.

In this exercise, you will create a k8s secret as well as a k8s configmap to correctly configure a MariaDB databse.

# Secrets

## Create the MYSQL_ROOT_PASSWORD secret

Generate a base-64 encoded string:
```
echo -n 'KubernetesTraining!' | base64
```

Note the value and put it in the secret definition:
```
apiVersion: v1
kind: Secret
metadata:
  name: mariadb-root-password 
type: Opaque
data:
  password: YOUR_VALUE
```

Then, create the `mariadb-root-password` secret:
```sh
kubectl apply -f mysql-secret.yaml
```

## View the secret:

```sh
kubectl describe secret mariadb-root-password
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}'|base64 -d
```

## Create a secret for the db user - second way to create a secret

```sh
kubectl create secret generic mariadb-user-creds \
      --from-literal=MYSQL_USER=kubeuser\
      --from-literal=MYSQL_PASSWORD=KubernetesTraining
```

## View the secret:

You are a k8s ninja!
You know how to do that.

# ConfigMap

## Create a configMap to configure the mariadb application

```sh
kubectl create configmap mariadb-config --from-file=max_allowed_packet.cnf
```

Edit the configMap to change the value 32M to `max_allowed_packet`.

View the configmap:
```sh
kubectl get configmap mariadb-config -o yaml
```

# Use the secrets and configMap

## Add 2 secrets as environment variables to the Deployment:

* `mariadb-root-password`: key/value pair
* `mariadb-user-creds`: key/value pair

Both elements must be added in the deployment:

```
env:
   - name: MYSQL_ROOT_PASSWORD
     valueFrom:
       secretKeyRef:
         name: mariadb-root-password
         key: password
```

and

```
envFrom:
- secretRef:
    name: mariadb-user-creds
```

## Add your configMap to the deployment

Add your ConfigMap as source, adding it to `volumes` entry of the pod spec. Then add a `volumeMount` to the container definition.

Use the configMap as a `volumeMount` to `/etc/mysql/conf.d` 

```
<...>

  volumeMounts:
  - mountPath: /var/lib/mysql
    name: mariadb-volume-1
  - mountPath: /etc/mysql/conf.d
    name: mariadb-config-volume

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
## Create the deployment

```sh 
kubectl create -f mariadb-deployment.yaml
```

Verify the pod uses the Secrets and ConfigMap
```
kubectl exec -it [pod-id] -- env |grep MYSQL
kubectl exec -it [pod-id] -- ls /etc/mysql/conf.d

kubectl exec -it [pod-id] -- cat /etc/mysql/conf.d/max_allowed_packet.cnf
```

## Check if it works
```sh
kubectl exec -it [pod-id] -- /bin/sh

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e 'show databases;'
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SHOW VARIABLES LIKE 'max_allowed_packet';"
```

# Clean
```
kubectl delete deployment mariadb-deployment
kubectl delete cm mariadb-config
kubectl delete secret mariadb-root-password mariadb-user-creds
```




