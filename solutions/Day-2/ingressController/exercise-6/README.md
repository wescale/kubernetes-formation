# exercise-6: IngressRules

In this exercise, you will create an application pod `/v1` and expose it through an Ingress targetting a Service.


Then you will create a second version of the application (`/v2`) and manage the routing via another Ingress.

## Deploy version /v1 of the application

Instead of creating a YAML file, use the imperative command `kubectl run` to create a pod with:
* name: `web`
* image: `gcr.io/google-samples/hello-app:1.0`
* declared port: 8080
>> kubectl run web --image=gcr.io/google-samples/hello-app:1.0 --port=8080

Instead of creating a YAML file, use the imperative command `kubectl expose` to create a NodePort service targetting the pod above.
>>> kubectl expose pod web --type=NodePort --target-port=8080 --port=80

Ensure the pod and the service are OK.
>> kubectl get pod web
>> kubectl get service web
>> kubectl describe service web


## Create an Ingress resource without path based routing rules

Here is the Ingress definition file:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: basic-ingress
spec:
  defaultBackend:
    service:
      name: web
      port:
        number: 80
```

Create the ingress. Be carefull, it may be incorrect regarding the service we want to target...
```sh
kubectl apply -f basic-ingress.yaml
```

Ensure the ingress is correctly created (it can take some time):
```sh
kubectl get ingress basic-ingress
kubectl descibe ingress basic-ingress
```

Test the connectivity - what is the IP to connect on ?

## Deploy a second version of the application

Create the Pod and service for the version 2:
```sh
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0 --port=8080
kubectl expose deployment web2 --target-port=8080 --port=8080 --type=NodePort
```

Complete the given `fanout-ingress.yaml` file to add a `/v2` path which targets the web2 service:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: fanout-ingress
spec:
  rules:
  - http:
      paths:
      - path: /v1
        pathType: ImplementationSpecific
        backend:
          service:
            name: web
            port:
              number: 80
      - path: /v2
        pathType: ImplementationSpecific
        backend:
          service:
            name: web2
            port:
              number: 8080
      ...
```

```sh
kubectl apply -f fanout-ingress.yaml
```

Ensure the ingress is correctly created (it can take some time):

```sh
kubectl get ingress fanout-ingress
```

Connect to the services via the new Ingress. 

Test URLs `/v1` and `/v2`.

## Clean
```
kubectl delete ingress basic-ingress
kubectl delete ingress fanout-ingress
kubectl delete pod web
kubectl delete deployment web2
kubectl delete service web web2
```
