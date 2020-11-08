# exercise-3: deployments to ensure pods are running

In this exercise, you will deploy pods via deployment resources.
You will see the interests of using deployment:
* easy update of pods
* horizontal scalability
* maintaining *n* replicas of pods

## Deploy version 1.0 with 2 replicas

Create a deployment file with the following content (be carefull, the provided `.yaml` file may be incorrect! See [the documentation if needed](https://v1-18.docs.kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#deploymentspec-v1-apps)):
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-dep
  namespace: default
spec:
  replicas-numberOf: 2
  selector:
    matchLabels:
      app: hello-dep 
  template:
    metadata:
      labels:
        app: hello-dep
    spec:
      containers:
      - image: gcr.io/google-samples/hello-app:1.0
        imagePullPolicy: Always
        name: hello-dep
        ports:
        - containerPort: 8080
```

Create the deployment:
```sh
kubectl apply -f hello-v1.yml
```

Ensure you have 2 running pods:
```sh
kubectl get deployment,pods
```

Now delete one of the 2 created pod:
```sh
kubectl delete pod/hello-dep-XXXX
```

Wait few seconds to see a replacement pod for the one you deleted:
```sh
kubectl get deployment,pods
```

## Deploy the version 2.0
```
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
```
kubectl apply -f hello-v2.yml
```

## "Scale up" the application

You will change the number of replicas:
```sh
kubectl scale deployment hello-dep --replicas=3
```

## Clean all the resources
```
kubectl delete deployment --all
```
