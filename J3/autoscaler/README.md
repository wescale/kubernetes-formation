##

Create the deployment:
```
kubectl apply -f deployment.yml
```

Create the horizontal autoscaler:
```
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
````

Generate load :
```
kubectl run -it --rm load-generator --image=busybox /bin/sh
# then
while true; do wget -q -O- http://php-apache; done
```

Watch the deployment and wait 1 minute:
```
kubectl get deployment php-apache -w
```

What does happen ?