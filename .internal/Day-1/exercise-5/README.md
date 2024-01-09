
# Exercise 5: Persistence with docker volumes

```yaml
version: '3'
services:

  nginx:
    image: nginx
    volumes:
      - "./nginx:/etc/nginx/conf.d"
    ports:
      - "8080:80"
    depends_on:
      - "article-svc"
      - "frontend-admin"

  frontend-admin:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/front-admin:1.0.0"
    depends_on:
      - "article-svc"
    volumes:
      - "./frontend-admin:/usr/share/nginx/html/config"

  article-svc:
    image: "europe-west1-docker.pkg.dev/wsc-kubernetes-training-0/microservices-demo/article-service:1.0.0"
    environment:
      MONGODB_URI: "mongodb://mongo:27017"
    depends_on:
      - "mongo"

  mongo:
    image: "mongo:4"
    volumes:
      - "dbdata:/data/db"

volumes:
  dbdata:
```
