# Persistent volume claims

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a persistent volume claim and reference that claim in a MongoDb pod.

You will write content to the persistent volume, then delete the pod.

Finally, you will check you retrieve the written content if you create another pod with the same reference to the PVC.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer: <walkthrough-project-setup></walkthrough-project-setup>

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## See the storage Classes

To get the list of all the available storage classes on the cluster:
```sh
kubectl get storageclass
```

Then, to get specific information about a storage class:
```sh
kubectl describe storageclass <STORAGE_CLASS_NAME>
```

## Create a Persistent Volume Claim

Here is a declaration for claiming **1 Gio** storage in **Read/Write** mode (for only one replica):
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mongo-pvc

spec:
  accessModes:
    - ReadWriteOneRingToRuleThemAll
  resources:
    requests:
      storage: 1GIBIOTETS
```

Fix the <walkthrough-editor-open-file filePath="mongo.pvc.yaml">mongo.pvc.yaml</walkthrough-editor-open-file> file. 
Then, create the PVC.

Questions:
* Do you see a persistent volume automatically created?
* Why?

## Create a pod which references the Persistent Volume Claim

Complete the given <walkthrough-editor-open-file filePath="mongo.pod.yaml">mongo.pod.yaml</walkthrough-editor-open-file> file to 
mount the volume created from the `mongo-pcv` pvc:

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: mongo

spec:
  volumes:
    - name: mongo-data
      # TODO: Complete volume declaration here
  containers:
    - name: mongo
      image: "mongo:7"
      ports:
        - containerPort: 27017
          name: "mongo"
      volumeMounts:
        - mountPath: "/data/db"
          name: mongo-data
```

Then, create the pod.

You should get a pv and a pod:
```sh
kubectl get pv,pvc,pod -o wide
```

## Write content to the persistent volume

Now, connect to the mongo pod:
```sh
kubectl exec -it mongo -- /usr/bin/mongosh
```

Then, write some content to the persistent volume:
```shell
db.article.insertOne({title: "My first article", content: "This is my first article"})
```

## Delete the pod and recreate it

Run the kubectl commands to delete the pod, and check the `pv` and `pvc`:
```shell
kubectl get pv,pvc -o wide
```

Re-create the pod. Then, reconnect to the pod:
```sh
kubectl exec -it mongo -- /usr/bin/mongosh
```

Check the data is still in the database:
```shell
db.article.find()
```

---
Yes, you can use a oneliner:
```shell
kubectl exec -it mongo -- /usr/bin/mongosh --eval "db.article.find()"
```

## Bonus: force the pod to be created on another node

Note the worker node which hosts the pod.
Then delete the `mongo` pod.

Edit the <walkthrough-editor-open-file filePath="mongo.pod.yaml">mongo.pod.yaml</walkthrough-editor-open-file> file and 
use the `nodeName` field in the spec to indicate another worker node.

Apply the changes.

Is it possible?

## Clean

Delete the pod:
```sh
kubectl delete po mongo
```

> If you delete the PVC before the pod, the pod will be stuck in the `Terminating` state.

Delete the Persistent Volume Claim:
```sh
kubectl delete pvc mongo-pvc
```

> Deleting the PVC will also delete the PV cause the reclaim policy is set to `Delete`.

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
