# Exercise 6: Run a complete app with multiple services

## Generate the config

```sh
bash ./define-config.sh
```

## Complete the docker-compose file

```yaml
version: '3'
services:

  ## Databases
  mongo:
    image: "mongo"
    volumes:
      - mongo-data:/data/db

  redis:
    image: "redis"
    volumes:
      - redis-data:/data

  ## APIs
  api-cart:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/cart-service:1.0"
    environment:
      REDIS_URI: "redis://redis"
    depends_on:
      - redis

  api-article:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:1.0"
    environment:
      MONGODB_URI: "mongodb://mongo"
    depends_on:
      - mongo


  ## Fronts
  front-admin:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-admin:1.0"
    volumes:
      - ./config/frontend-admin.json:/usr/share/nginx/html/config/endpoints.json:ro

  front-client:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/frontend-user:1.0"
    volumes:
      - ./config/frontend-user.json:/usr/share/nginx/html/config/endpoints.json:ro


  ## Incoming traffic
  ingress:
    image: nginx:1.19
    ports:
      - "8080:80"
    volumes:
      - ./config/default.conf:/etc/nginx/conf.d/default.conf:ro
    depends_on:
      - api-cart
      - api-article
      - front-admin
      - front-client
  
volumes:
  mongo-data:
  redis-data:
```
