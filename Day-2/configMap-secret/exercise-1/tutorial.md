# A secret and a configuration for a database

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a k8s secret as well as a k8s configmap to correctly configure a MariaDB database.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Create the MYSQL_ROOT_PASSWORD secret

Generate a base-64 encoded string:

```sh
echo -n 'KubernetesTraining' | base64
```

Note the value and put it in the <walkthrough-editor-open-file filePath="mysql-secret.yaml">mysql-secret.yaml</walkthrough-editor-open-file>  file:

```yaml
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

View the secret:

```sh
kubectl describe secret mariadb-root-password
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}' | base64 -d
```

## Second way to create a secret

You can declaratively create the secret:

```sh
kubectl create secret generic mariadb-user-creds \
      --from-literal=MYSQL_USER=kubeuser\
      --from-literal=MYSQL_PASSWORD=KubernetesTraining
```

View the secret: You are a k8s ninja, you know how to do that.

## Create a configMap to configure the mariadb application

See the <walkthrough-editor-open-file filePath="max_allowed_packet.cnf">max_allowed_packet.cnf</walkthrough-editor-open-file> configuration file for mariadb.

Create the config map `mariadb-config` from this file:

```sh
kubectl create configmap # Complete arguments
```

Edit the configMap to change the value of `max_allowed_packet` to 32M.

## Use the secrets as environment variables in a deployment

Add 2 secrets as environment variables to the <walkthrough-editor-open-file filePath="mariadb-deployment.yaml">mariadb-deployment.yaml</walkthrough-editor-open-file> deployment file:

* `mariadb-root-password`: key/value pair
* `mariadb-user-creds`: key/value pair

Both elements must be added in the deployment:

```yaml
env:
   - name: MYSQL_ROOT_PASSWORD
     valueFrom:
       secretKeyRef:
         name: mariadb-root-password
         key: password
```

and

```yaml
envFrom:
- secretRef:
    name: mariadb-user-creds
```

## Use a configmap as a volume in a deployment

Add your ConfigMap as source into the `volumes` entry of the pod spec. Then add a `volumeMount` to the container definition.

Use the configMap as a `volumeMount` to `/etc/mysql/conf.d`.

See the documentation for help.

## Create the deployment

```sh
kubectl create -f mariadb-deployment.yaml
```

Verify the pod uses the Secrets and ConfigMap

```sh
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

## Clean

```sh
kubectl delete deployment mariadb-deployment
kubectl delete cm mariadb-config
kubectl delete secret mariadb-root-password mariadb-user-creds
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
