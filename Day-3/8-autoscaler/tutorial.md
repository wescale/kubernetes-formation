# Horizontal autoscaler

<walkthrough-tutorial-duration duration="15.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create and use an horizontal autoscaler.

After deploying the API article-service exposed by a service, you will generate load and see the scale-out then scale-down.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy the application

A <walkthrough-editor-open-file filePath="deployment.yml">deployment.yml</walkthrough-editor-open-file> file with a service is provided.

Create the resources:

```sh
kubectl apply -f deployment.yml
```

Ensure the deployment is correctly done.

## Create an Horizontal Pod Autoscaler

This HPA must be bound to minimum 1 Pod and maximum 10 Pods.

It must target a CPU usage of 50%.

Create the horizontal autoscaler with the `kubectl autoscale` command:

```sh
kubectl autoscale deployment article-service ...
```

Like all k8s objects, you can query the hpa:

```sh
kubectl describe hpa
```

Wait a minute to ensure the HPA has collected some metrics to do its job.

## Generate load

With a basic linux container:

```sh
kubectl run -it --rm load-generator --image=busybox /bin/sh
```

Then run a `wget` in a loop:

```sh
while true; do wget -q -O- http://article-svc/article; done
```

Watch the deployment and wait 1 minute:

```sh
kubectl get deployment article-service -w
```

What does happen ?

## Clean

```sh
kubectl delete hpa --all
kubectl delete -f deployment.yml
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
