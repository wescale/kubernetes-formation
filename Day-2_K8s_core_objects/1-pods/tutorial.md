# Create a pod, execute commands inside then delete it

<walkthrough-tutorial-duration duration="15.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create a MongoDB pod.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:
```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:
```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Start the pod

You need to complete the <walkthrough-editor-open-file filePath="mongodb.yml">mongodb.yml</walkthrough-editor-open-file> 
file to declare a `mongo` container into the `mongo` pod with the following characteristics:
- name: `mongo`
- image: `mongo:7`
- ports: name `mongo`: `27017` (TCP)

To know the name of the attributes, you can run `kubectl explain Pod.spec.containers` or read the [API reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#container-v1-core).


Then create the pod:
```sh
kubectl create -f mongodb.yml
```

## List all the pods

Run `kubectl get pods` to see the status of the pods. 

Note the `-w` and `-o wide` options for watching and getting more complete output.

```sh
kubectl get pods -o wide
```

Note the IP of the `mongo` POD.

**Question**: If you try to access the Pod IP from the CloudShell instance, does it work?

## Leave the container and delete the pod

```sh
kubectl delete pod mongo
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
