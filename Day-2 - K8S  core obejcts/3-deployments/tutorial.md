# Deployments to ensure pods are running

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will deploy pods via deployment resources.

You will see the interests of using deployment:

* easy update of pods
* horizontal scalability
* maintaining *n* replicas of pods

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy version 1.0 with 2 replicas

Edit <walkthrough-editor-open-file filePath="hello-v1.yml">hello-v1.yml</walkthrough-editor-open-file> file to correct it. See [the documentation if needed](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#deployment-v1-apps))

Create the deployment:

```sh
kubectl apply -f hello-v1.yml
```

Ensure you have 2 running pods:

```sh
kubectl get deployment,pods
```

Now delete one of the 2 created pods:

```sh
kubectl #Find the command
```

Wait few seconds to see a replacement pod for the one you deleted:

```sh
kubectl get deployment,pods
```

## Deploy the version 2.0

See the content of <walkthrough-editor-open-file filePath="hello-v2.yml">hello-v2.yml</walkthrough-editor-open-file> file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-dep
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hello-dep 
  template:
    metadata:
      labels:
        app: hello-dep
    spec:
      containers:
      - image: gcr.io/google-samples/hello-app:2.0
        imagePullPolicy: Always
        name: hello-dep
        ports:
        - containerPort: 8080
```

Apply the changes:

```sh
kubectl apply -f hello-v2.yml
```

## "Scale up" the application

You will change the number of replicas to get 3 pods:

```sh
kubectl scale deployment hello-dep #Find the option!!
```

## Clean all the resources

```sh
kubectl delete deployment --all
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
