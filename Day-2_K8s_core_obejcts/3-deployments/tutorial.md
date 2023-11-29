# Exercise 2.3 - Deployments to ensure pods are running

<walkthrough-tutorial-duration duration="25.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will deploy pods via deployment resources.

You will see the interests of using deployment:
* easy update of pods
* horizontal scalability
* maintaining *n* replicas of pods

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer: <walkthrough-project-setup></walkthrough-project-setup>

Now, you must retrieve the credentials of the kubernetes cluster:
```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy MongoDb instance

Edit <walkthrough-editor-open-file filePath="mongodb.deploy.yml">mongodb.deploy.yml</walkthrough-editor-open-file> 
file to correct it. 
> See [the documentation if needed](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#deployment-v1-apps)

Create the deployment:
```sh
kubectl apply -f mongodb.deploy.yml
```

Ensure you have 1 running pod:
```sh
kubectl get deployment,pods
```

Now, delete the pod:
```sh
kubectl #Find the command
```

Wait few seconds to see a replacement pod for the one you deleted:
```sh
kubectl get deployment,pods
```

## Deploy the article microservice

See the content of <walkthrough-editor-open-file filePath="article.deploy.yml">article.deploy.yml</walkthrough-editor-open-file> 
file. Define **2 replicas** for the microservice.

Then, create the deployment:
```sh
kubectl apply -f article.deploy.yml
```

Ensure you have 2 running pods:
```sh
kubectl get deployment,pods
```

You'll see that the pods are in the `CrashLoopBackOff` state: This is because the microservice needs a MongoDB instance 
to work. You can check that by looking at the logs of one of the pods:
```sh
kubectl logs <POD_NAME>
```

To access to the mongodb instance, you need to expose it. You can do that by creating a service (We'll see that in details
in a future exercise). For now, you can do that by running the following command:
```sh
kubectl expose deployment mongodb --port 27017
```

Then, to fix the crashing pods, add the following environment variables to the `article-api` deployment:
* `MONGODB_URI`: `mongodb://mongodb`

> See [the documentation if needed](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#podspec-v1-core)

You can check that the pods are now running:
```sh
kubectl get deployment,pods
```

And check the logs of one of the pods:
```sh
kubectl logs <POD_NAME>
```

## "Scale up" the application

You will change the number of replicas to get 3 pods:
```sh
kubectl scale deployment article-api #Find the option!!
```

## Clean all the resources

```sh
kubectl delete deployment --all
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
