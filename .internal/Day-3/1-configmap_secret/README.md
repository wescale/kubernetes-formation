# exercise-1: A secret and a configmap for a database.

In this exercise, you will create a k8s secret as well as a k8s configmap to correctly configure a MongoDB database.

# Secrets

## Create the MONGO_INITDB_ROOT_PASSWORD secret

Generate a base-64 encoded string:
```
echo -n 'KubernetesTraining' | base64
```

Note the value and put it in the secret definition:
```
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
kubectl describe secret mongo-root-password
kubectl get secret mongo-root-password -o jsonpath='{.data.password}' | base64 -d
```

## Create a secret for the db user - second way to create a secret

```sh
kubectl create secret generic mongo-user-creds \
      --from-literal=MONGO_INITDB_ROOT_USERNAME=kubeuser \
      --from-literal=MONGO_INITDB_ROOT_PASSWORD=KubernetesTraining
```

## View the secret:

You are a k8s ninja!
You know how to do that.

```sh
kubectl get secret mongo-user-creds -o jsonpath='{.data.MONGO_INITDB_ROOT_PASSWORD}' | base64 -d
kubectl get secret mongo-user-creds -o jsonpath='{.data.MONGO_INITDB_ROOT_USERNAME}' | base64 -d
```

# ConfigMap

## Create a configMap to configure the mongoDB application

Create the config map `mongod-config` from the `mongod.conf` file.
```sh
kubectl create configmap mongod-config --from-file=mongod.conf
```

Edit the configMap to change the value `net.maxIncomingConnections` to 10000.

```sh
kubectl edit configmap mongod-config
```

# Use the secrets and configMap

## Add 2 secrets as environment variables to the Deployment:

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

## Add your configMap to the deployment

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




