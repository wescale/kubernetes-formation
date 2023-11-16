# Exercice-4: Multiple services

<walkthrough-tutorial-duration duration="20.0"></walkthrough-tutorial-duration>

## Description

In this exercise you will deploy 3 services to run a Wordpress site.

To do that, you get a docker-compose skeleton file. You must complete the file with the correct instructions.

## Launch the application

Complete the <walkthrough-editor-open-file filePath="docker-compose.yml">docker-compose.yml</walkthrough-editor-open-file> file.

We want to persist the database data directory (`/var/lib/mysql`) outside of the containers, using a volume mount.

To know how to configure the containers, read the documentation on the Docker Hub:

* a [MariaDB](https://hub.docker.com/_/mariadb/) database
* a [PhpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) interface to be connected to MariaDB
* a PHP Wordpress application [Wordpress](https://hub.docker.com/_/wordpress/)

Please consult the [Docker Compose specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md) if you need help.

You can launch the following command to start all the services:

```sh
docker compose up -d
```

Open a tab to the wordpress administration page by clicking on the <walkthrough-web-preview-icon></walkthrough-web-preview-icon> icon.

Enter a name for the website, and an administrator login/password.

When the initialization is finished, you must log in again to access the back office.

## Restart the containers

Enter the `docker-compose` command to restart the containers :

```sh
docker-compose restart
```

Refresh the wordpress administration page to ensure you retrieve the site name you entered previously:

```sh
echo "Open the administration URL: https://8080-${WEB_HOST}/wp-admin/options-general.php"
```

## Bonus

The data directory mounted by MariaDB (`.data` in the solution) is created with the docker engine user id...**root**.  To be cleaner, the volume would be managed by Docker, in `/var/lib/docker/volumes/`.

How can you do that?

## Clean

To delete all the resources created (including network and volumes):

```sh
docker compose down --volumes
```

## Congratulations

You have finished this exercise!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>
