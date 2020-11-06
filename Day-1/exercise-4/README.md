# exercice-4: with 3 services...

## Instructions

In this exercise you will deploy 3 services to run Wordpress site.

The 3 components are images already existing on Docker Hub:

  - PHP Wordpress application [Wordpress](https://hub.docker.com/_/wordpress/) itself
  - a [MariaDB](https://hub.docker.com/_/mariadb/) database
  - a [PhpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) interface to be connected to MariaDB

We want to persist the database data directory (`/var/lib/mysql`) outside of the containers, using a volume mount.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## Launch the application

Once your `docker-compose.yml` written, you can launch the following command to start all the services:
```sh
docker-compose up -d
```

To test if your application works well, you can consult this page: 

To control if you Wordpress site is up and running, go to the[http://[BASTION IP]:8080](http://localhost:8080) page and start the initialization steps.
You can now see the changes on the DB using the PhpMyAdmin container.

You can use the standard docker-compose commands to stop and delete the containers.
You can create them again to verify the data have not been lost, thank to the volume mount for the MariaDB data.


*About the mount volume:* The data directory mounted by MariaDB (`.data` in the solution) is created with the docker engine user id...**root**.  To be cleaner, the volume would be managed by Docker, in `/var/lib/docker/volumes/`.

How can you do that?

