# exercise-8: Horizontal autoscaler

In this exercise, you will create and use an horizontal autoscaler.
After deploying a PHP webserver exposed by a service, you will generate load and see the scale-out then scale-down.

## Deploy the application

```sh
kubectl apply -f deployment.yml
```

Ensure the deployment is correctly done.

## Create an Horizontal Pod Autoscaler

This HPA must be bound to min 1 Pod and max 10 Pods.
It must target a CPU usage of 50%.

Create the horizontal autoscaler:
```
kubectl autoscale deployment php-apache ...
````

Like all k8s objects, you can query the hpa
```sh
kubectl describe hpa
```

## Generate load
```sh
kubectl run -it --rm load-generator --image=busybox /bin/sh
# then
while true; do wget -q -O- http://php-apache; done
```

Watch the deployment and wait 1 minute:
```
kubectl get deployment php-apache -w
```

What does happen ?

## Clean 

```sh
kubectl delete hpa --all
kubectl delete -f deployment.yml
```