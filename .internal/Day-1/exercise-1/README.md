## Start the Redis container

Pull then start the Redis server:
```sh
docker run -d --name redis redis
```

La commande à lancer est la suivante :
```sh
docker run -d --name pythonapp --network my-net -p 8080:5000 myrepo/pythonapp
```

Enter the pythonapp container and show the /etc/hosts file.
Enter the pythonapp container and show the /etc/resolv.conf file.

-> DNS server on 127.0.0.11 provided once a container is in Docker network.
See <https://docs.docker.com/network/#dns-services>
