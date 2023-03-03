# exercise-1: A secret and a configmap for a database.

In this exercise, you will create a k8s secret as well as a k8s configmap to correctly configure a MariaDB database.

# Secrets

## Create the MYSQL_ROOT_PASSWORD secret

Generate a base-64 encoded string:
```
echo -n 'KubernetesTraining' | base64
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
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}' | base64 -d
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

```sh
kubectl get secret mariadb-user-creds -o jsonpath='{.data.MYSQL_PASSWORD}' | base64 -d
```

# ConfigMap

## Create a configMap to configure the mariadb application

Create the config map `mariadb-config` from the `max_allowed_packet.cnf` file.
```sh
kubectl create configmap # Complete arguments
```

Edit the configMap to change the value 32M to `max_allowed_packet`.

```sh
kubectl edit configmap mariadb-config
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

Add your ConfigMap as source into the `volumes` entry of the pod spec. Then add a `volumeMount` to the container definition.

Use the configMap as a `volumeMount` to `/etc/mysql/conf.d` 

See the documentation for help.

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




