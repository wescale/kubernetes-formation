
# Exercise 7: Demo service discovery with Traefik

## Launch the application

What are the routing rules for those services ?
- `api-article-infra` -> `api-article:8080`
- `api-cart-infra` -> `api-cart:8081`
- `front-admin-infra` -> `front-admin:80`
- `front-client-infra` -> `front-client:80`
- `mongo-infra` -> `mongo:27017`
- `redis-infra` -> `redis:6379`
- `test-infra` -> `test:8080`
 
What are the containers IP behind those services ?
> The IPs are visible on the service page, in the "Server" card.

## Mark a container down

What happened in Traefik ?
> The service is removed from the list. Only 3 servers are now available for this service.
