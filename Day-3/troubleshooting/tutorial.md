# Troubleshooting

<walkthrough-tutorial-duration duration="55.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will troubleshoot an application of microservices deployed in the `application` namespace.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Instructions

With `kubectl`, investigate and fix the different resources.

Usefull commands: 
- `kubectl get events`, 
- `kubectl logs`
- `kubectl get all`
- `kubectl get endpoints`
- and of course `kubectl describe`.



You have finished the exercise once the [microservices-demo stack](https://github.com/wescale/microservices-demo) is functional, accessing the NodePort service with your web browser.


Since the application to troobleshoot is not in the default namespace, it's mandatory to add `--namespace application` or `-n application` in all kubectl command
To save time you can specify the namespace as default in your current config with this command :
```sh
kubectl config set-context --current --namespace=application
```

## Congratulations

You have finished the Kubernetes fundamentals training!!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
