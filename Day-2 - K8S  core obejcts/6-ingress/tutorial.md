# Ingress rules

<walkthrough-tutorial-duration duration="30.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create an application pod `/v1` and expose it through an Ingress targetting a Service.

Then you will create a second version of the application (`/v2`) and manage the routing via another Ingress.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
```

## Deploy version /v1 of the application

Instead of creating a YAML file, use the imperative command `kubectl run` to create a pod with:

* name: `web`
* image: `gcr.io/google-samples/hello-app:1.0`
* declared port: 8080

Instead of creating a YAML file, use the imperative command `kubectl expose` to create a NodePort service targetting the pod above.

Ensure the pod and the service are OK.

## Create an Ingress resource without path based routing rules

Edit and correct the <walkthrough-editor-open-file filePath="basic-ingress.yaml">basic-ingress.yaml</walkthrough-editor-open-file> file:

```yaml
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

Create the ingress:

```sh
kubectl apply -f basic-ingress.yaml
```

Ensure the ingress is correctly created (it can take some time):

```sh
kubectl get ingress basic-ingress
```

Test the connectivity - what is the IP to connect on ?

## Deploy a second version of the application

Create the Pod and service for the version 2:

```sh
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0 --port=8080
kubectl expose deployment web2 --target-port=8080 --port=8080 --type=NodePort
```

Complete the given <walkthrough-editor-open-file filePath="fanout-ingress.yaml">fanout-ingress.yaml</walkthrough-editor-open-file> file to add a `/v2` path which targets the web2 service:

```yaml
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
      # Add /v2 path
      ...
```

Create this new fanout ingress:

```sh
kubectl apply -f fanout-ingress.yaml
```

Ensure the ingress is correctly created (it can take some time):

```sh
kubectl get ingress fanout-ingress
```

Connect to the services via this new ingress.

Test URLs `/v1` and `/v2`.

## Clean

```sh
kubectl delete ingress basic-ingress
kubectl delete ingress fanout-ingress
kubectl delete pod web
kubectl delete deployment web2
kubectl delete service web web2
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
