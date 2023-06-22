#  Install an application from a predefined chart

The objective of this exercise is to migrate the k8s configuration from an application to Helm.
This is a simple two-thirds application: frontend and backend

Rewrite the different yaml files for this using Chart Helm. You find here:

- _helpers.tpl
 This file is as a place where you store all the reusable part. Typically something like application name, deployment name, service name, etc. In this file, we can also use a template function: for example here we defined `simplebackend.fullname` with value taken from `.Release.Name` and `.Chart.Name` ended by “backend”. 


- values.yaml: 
We put the Image repository and container ports for both backend and frontend. At this point, we can use the chart later to deploy different application image and maybe publish it on different ports.

- deployment.yaml

We can create our template for deployment in templates/deployment.yaml. This template will be used to generate both backend-deployment.yamland frontend-deployment.yaml

- service.yaml
This template will be used to generate both backend-service.yaml and frontend-service.yaml 

- Install the application. And voila you have an application up and running in the kubernetes cluster. Check it out.
```sh
$ helm install simpleapp ./sample-demo
```