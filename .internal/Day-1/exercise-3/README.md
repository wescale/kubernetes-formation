
## The mongodb container

### Run the mongodb container

```bash
docker run --name mongo -d mongo
```

### The article-service container

```bash
docker run \
  --name article-service \
  --network my-net \
  -e MONGODB_URI=mongodb://mongo:27017 \
  -d  \
  alphayax/microservice-demo-article-service:latest 
```

### Question

How is the resolution of `mongo` done inside the `article-svc` container?
> The resolution is done by the docker network. The container `article-svc` is connected to the 
> network `my-net` and can resolve the hostname `mongo` to the IP of the container `mongo`.
