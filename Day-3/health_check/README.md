# exercise-4: Healthcheck and probes

In this exercise, you will explore the Readiness/Liveness probes.

You will create an healthy deployment which passes the liveness/readiness probes.

Then you will update the deployment and see if the new pods serve traffic.

## Deploy an healthy service

Deploy the service and the deployment:
```sh
kubectl apply -f service.yaml
kubectl apply -f healthy-deployment.yaml
```

Ensure all the pods are running and READY:
```sh
kubectl get pods -o wide
```
## Request the site

Get the connexion information:
```sh
kubectl get services
```

Then open the service endpoint in your web-browser.

What is the displayed version?

## Update the deployment with failing pods

```sh
kubectl apply -f broken-deployment.yaml
```

Try to wait few minutes, the time for the pods to be running and READY:
```sh
kubectl get pods -o wide -w
```

## Get information

Retrieve events:
```sh
kubectl get events --sort-by=.metadata.creationTimestamp --field-selector type!=Normal
```

What do they explain?
What will happen to the failing pods?

## Request the site

What version of the site is displayed?

## Clean

Suppress all the created resources:
```sh
kubectl delete -f service.yaml
kubectl delete -f broken-deployment.yaml
kubectl delete -f healthy-deployment.yaml
```