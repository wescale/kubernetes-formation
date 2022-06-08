## Start the Redis container

Pull then start the Redis server:
```sh
  docker run -d --name redis redis
```

La commande à lancer est la suivante :
```
  docker run -d --name nodeapp --link redis -p 8080:8080 myrepo/nodeapp
```

Enter the nodeapp container and show the /etc/hosts file.
Best solution is to use a DNS -> create dedicated network.

Demo, if needed...
## Create a user-defined bridge network

```sh
  docker network create my-net
```
## Connect the redis container to your user-defined bridge network

```sh
  docker network connect my-net redis
```


```sh
  docker run -d --name nodeapp --network my-net -p 8080:8080 myrepo/nodeapp
```
