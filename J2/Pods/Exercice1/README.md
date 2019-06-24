# Create a yaml file containing the pod spec for the nginx pod.

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: development

spec:
  containers:
  - name: nginx
    image: nginx
    command: ["nginx"]
    args: ["-g", "daemon off;", "-q"]
    ports:
    - containerPort: 80

# Create the pod.
kubectl create -f nginx.yml

# You should see the pod listed with this command and It should have a status of Running.
kubectl get pods

# Get a shell to the running Container:
kubectl exec -it nginx -- /bin/bash

# In your shell, list the root directory:
ls -l

# Writing the root page for nginx
echo Hello shell demo > /usr/share/nginx/html/index.html

# Install Curl
apt-get update
apt-get install -Y curl

# Test nginx and hello page
curl localhost

# Exit container in pod and delete it
kubectl delete pod nginx