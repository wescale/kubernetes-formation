## Start the Redis container

Pull then start the Redis server:
```sh
  docker run -d --name redis redis
```

La commande à lancer est la suivante :
```
  docker run -d --name nodeapp --link redis -p 8080:8080 myrepo/nodeapp
```
