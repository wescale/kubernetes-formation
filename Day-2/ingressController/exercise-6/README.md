# exercise-6: IngressRules

In this exercise, you will create an application pod `/v1` and expose it through an Ingress targetting a Service.


Then you will create a second version of the application (`/v2`) and manage the routing via another Ingress.

## Deploy version /v1 of the application

Create the pod:
```sh
kubectl run web --image=gcr.io/google-samples/hello-app:1.0 --port=8080
```

Expose the pod as a service:
```sh
kubectl expose pod web --target-port=8080 --type=NodePort
kubectl get service web
```

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
      name: oueb
      port:
        number: 666
```

Create the ingress. Be carefull, it may be incorrect regarding the service we want to target...
```sh
kubectl apply -f basic-ingress.yaml
```

Ensure the ingress is correctly created (it can take some time):
```sh
kubectl get ingress basic-ingress
```

Test the connectivity - what is the URL to connect on ?
* On GKE, see the External IP
* On OVHCLoud, see the NodePort of the Nginx ingress controller `kubectl get svc ingress-nginx-controller -n ingress-nginx`

## Deploy a second version of the application

Create the Pod and service for the version 2:
```sh
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0 --port=8080
kubectl expose deployment web2 --target-port=8080 --type=NodePort
```

Create a new Ingress with the routing rules:
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
              number: 8080
      - path: /v2
        pathType: ImplementationSpecific
        backend:
          service:
            name: web2
            port:
              number: 8080
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
