## Start the Redis container

Pull then start the Redis server:
```sh
  docker run -d --name redis redis
```

La commande à lancer est la suivante :
```
  docker run -d --name nodeapp --network my-net -p 8080:8080 myrepo/nodeapp
```

Enter the nodeapp container and show the /etc/hosts file.
Enter the nodeapp container and show the /etc/resolv.conf file.

If needed, start a ubuntu container connected to the network, then run `dig`to illustrate the DNS resolution.
