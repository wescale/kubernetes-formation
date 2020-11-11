# exercise-4: Rolling-update

In this exercise, you will deploy a version *v1* of you application.

After performing a rolling update to the version *v1.1*, you will do a rollback to *v1*.

## Deploy the version v1

Complete the provided `deployment-v1.0.yaml` file to in dicate the deployment strategy:
```
strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```

Then create the deployment:
```sh
kubectl apply -f deployment-v1.0.yaml
```

## Ensure everythin is fine

```sh
kubectl get deployments
kubectl describe deployments kdemo-dep
kubectl get pods -o wide
```

## Create a service to externally expose the deployment
```sh
kubectl expose deployment kdemo-dep \
--type=NodePort \
--name=kdemo-svc \
--port=80 \
--target-port=8080
```
ou 
```
kubectl create -f service.yaml
```

Retrieve the external IP/port.

Then display the service in your web Browser.

## Deploy the new version of the site
```sh
kubectl apply -f deployment-v1.1.yaml
```
## Check the pod status
```sh
watch kubectl get pods -o wide
```

Verify you get a new version of the website in your broser.

## RollBack to v1.0
```sh
kubectl rollout undo deployment kdemo-dep

kubectl rollout status deployment kdemo-dep
```
## Clean

```sh
kubectl delete services kdemo-svc
kubectl delete -f deployment-v1.1.yaml
```