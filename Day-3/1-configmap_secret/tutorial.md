# A secret and a configuration for a database

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a k8s secret as well as a k8s configmap to correctly configure a MongoDB database.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Create the MONGO_INITDB_ROOT_PASSWORD secret

Generate a base-64 encoded string:

```sh
echo -n 'KubernetesTraining' | base64
```

Note the value and put it in the <walkthrough-editor-open-file filePath="mongo-secret.yaml">mongo-secret.yaml</walkthrough-editor-open-file>  file:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mongo-root-password 
type: Opaque
data:
  password: YOUR_VALUE
```

Then, create the `mongo-root-password` secret:

```sh
kubectl apply -f mongo-secret.yaml
```

View the secret:

```sh
kubectl describe secret mongo-root-password
kubectl get secret mongo-root-password -o jsonpath='{.data.password}' | base64 -d
```

## Second way to create a secret

You can declaratively create the secret:

```sh
kubectl create secret generic mongo-user-creds \
      --from-literal=MONGO_INITDB_ROOT_USERNAME=kubeuser \
      --from-literal=MONGO_INITDB_ROOT_PASSWORD=KubernetesTraining
```

View the secret: You are a k8s ninja, you know how to do that.

## Create a configMap to configure the mongoDB application

See the <walkthrough-editor-open-file filePath="mongod.conf">mongod.conf</walkthrough-editor-open-file> configuration file for mongodb.

Create the config map `mongod-config` from the `mongod.conf` file. Complete this command:

```sh
kubectl create configmap # Complete arguments
```

Edit the configMap to change the value of `net.maxIncomingConnections` to 10000.

## Use the secrets as environment variables in a deployment

Add 2 secrets as environment variables to the <walkthrough-editor-open-file filePath="mongo-deployment.yaml">mongo-deployment.yaml</walkthrough-editor-open-file> deployment file:

* `mongo-root-password`: key/value pair
* `mongo-user-creds`: key/value pair

Both elements must be added in the deployment:

```yaml
env:
   - name: MONGO_INITDB_ROOT_PASSWORD
     valueFrom:
       secretKeyRef:
         name: mongo-root-password
         key: password
```

and

```yaml
envFrom:
- secretRef:
    name: mongo-user-creds
```

## Use a configmap as a volume in a deployment

Add your ConfigMap as source into the `volumes` entry of the pod spec. Then add a `volumeMount` to the container definition.

Use the configMap as a `volumeMount` to `/etc/mongo`.

See the documentation for help.

## Create the deployment

```sh
kubectl create -f mongo-deployment.yaml
```

Verify the pod uses the Secrets and ConfigMap

```sh
kubectl exec -it [pod-id] -- env |grep MONGO
kubectl exec -it [pod-id] -- ls /etc/mongo

kubectl exec -it [pod-id] -- cat /etc/mongo/mongod.conf
```

## Check if it works

```sh
kubectl exec -it [pod-id] -- /bin/sh

mongosh --host localhost -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD}

test> db.getName();
test> exit

```

## Clean

```sh
kubectl delete deployment mongo-deployment
kubectl delete cm mongod-config
kubectl delete secret mongo-root-password mongo-user-creds
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
