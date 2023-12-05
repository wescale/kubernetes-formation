
# Exercise 2.6 - Ingress rules

## Deploy the Database

```sh
kubectl create deploy mongo --image mongo:7 --port 27017
```

```sh
kubectl expose deployment mongo --port=27017 --target-port=27017 --name=mongo --type=ClusterIP
```
