
# Exercise 2.1 - Create a pod, execute commands inside then delete it

## Start the pod

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: mongo
  labels:
    env: development

spec:
  containers:
    - name: mongo
      image: mongo:5
      ports:
          - containerPort: 27017
            name: mongo
            protocol: TCP
...
```

## Execute a Shell inside the nginx container

**Question**: If you try to access the Pod IP from the CloudShell instance, does it work?
> No. The Pod IP is not accessible from outside the cluster.
