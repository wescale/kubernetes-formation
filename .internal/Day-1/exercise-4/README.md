
# Exercise 4: Manage multiple containers with docker-compose

## Launch the application

Check the complete [docker-compose.yml](docker-compose.1.yml)

## Question

How is the address resolution performed from the `article-service` container?
> The `article-service` container uses the `mongo` hostname to connect to the `mongo` container.
> 
> The `mongo` hostname is resolved to the `mongo` container IP address.
> 
> The `mongo` container IP address is resolved by the Docker embedded DNS server.

## Add a frontend

Check the complete [docker-compose.yml](docker-compose.2.yml)
