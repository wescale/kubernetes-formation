# Create a pod, execute commands inside then delete it

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise, you will create an Nginx pod and modify it to serve specific content.

Then you will connect to it.

## Project selection and credentials

Please ensure your Google Cloud project is the one given by the trainer:

```sh
gcloud config set project XXX 
```

Now, you must retrieve the credentials of the kubernetes cluster:

```sh
gcloud container clusters get-credentials training-cluster --project ${GOOGLE_CLOUD_PROJECT} --zone europe-west1-b
# Ensure you see 3 nodes running:
kubectl get nodes
```

## Start the pod

You need to complete the <walkthrough-editor-open-file filePath="nginx.yml">nginx.yml</walkthrough-editor-open-file> file to declare a `nginx` pod with the following characteristics:

* name: nginx
* image: <nginx:latest>
* entrypoint: "nginx"
* entrypoint options: "-g", "daemon off;", "-q"
* exposed port : 80

To know the name of the attributes, you can run `kubectl explain Pod.spec.containers` or read the [API reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#container-v1-core).

Then create the pod:

```sh
kubectl create -f nginx.yml
```

## List all the pods

Run `kubectl get pods` to see the status of the pods. Note the `-w` and `-o wide` options for watching and getting more complete output.

```sh
kubectl get pods -o wide
```

Note the IP of the nginx POD.

## Execute a Shell inside the nginx container

With `kubectl exec` you can execute commands inside a container:

```sh
kubectl exec -it nginx -- /bin/bash
```

You can create an `index.html` file with the content "Hello shell demo" inside `/usr/share/nginx/html/`

```sh
echo Hello shell demo > /usr/share/nginx/html/index.html
```

## Test the nginx server

Still from the conatiner, you must see the "Hello shell demo" string:

```sh
curl http://localhost
curl http://<IP_POD>
```

Exit the shell from inside the container.

**Question**: If you try to access the Pod IP from the CloudShell instance, does it work?

## Leave the container and delete the pod

```sh
kubectl delete pod nginx
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
