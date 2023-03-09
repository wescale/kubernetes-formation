# Persistent volume claims

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a persistent volume claim and reference that claim in an nginx pod.

You will write content to the persistent volume, then delete the pod.

Finally, you will check you retrieve the written content if you create an other pod with the same reference to the PVC.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## See the storage Classes

```sh
kubectl get storageClass
kubectl describe storageClass [name storageClass]
```

## Create a Persistent Volume Claim to ask a 1Gi R/W storage

Here is the claim declaration:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  accessModes:
    - ReadWriteOneRingToRuleThemAll
  resources:
    requests:
      storage: 1GOCTETS
```

Edit the <walkthrough-editor-open-file filePath="pv-claim.yaml">pv-claim.yaml</walkthrough-editor-open-file> file to fix it.

Then, create the PVC.

Questions:

* Do you see a persistent volume automatically created?
* Why?

## Create a pod which references the Persistent Volume Claim

Complete the given <walkthrough-editor-open-file filePath="pv-pod.yaml">pv-pod.yaml</walkthrough-editor-open-file> file to mount the volume created from the `task-pv-claim` pvc:

```sh
kind: Pod
apiVersion: v1
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      # Complete volume declaration here
      ...
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage
```

Create the pod.

You should get a pv and a pod:

```sh
kubectl get pv,pod -o wide
```

## Write content to the persistent volume

Now, write content to the persistent volume:

```sh
kubectl exec -it task-pv-pod -- bash
echo 'K8s rules!' > /usr/share/nginx/html/index.html
curl http://localhost
```

## Delete the pod and recreate it

Run the kubectl commands to delete the pod.
Then create-it again.

Check the index.html file still exists.

## Bonus: force the pod to be created on another node

Note the worker node which hosts the pod.
Then delete the task-pv-pod pod.

Edit the <walkthrough-editor-open-file filePath="pv-pod.yaml">pv-pod.yaml</walkthrough-editor-open-file>  file and use the `nodeName` field in the spec to indicate another worker node.

Apply the changes.

Is it possible?

## Clean

```sh
kubectl delete pvc task-pv-claim
kubectl delete po task-pv-pod
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
