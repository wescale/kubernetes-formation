## Exercice n°4 : Et avec 3 services ?

Cet exercice consiste à orchestrer 3 services, pour mettre en place un site Wordpress.

Les 3 services que nous mettrons en oeuvre utilisent des images déjà existantes sur le Docker Hub :

  - l'application PHP [Wordpress](https://hub.docker.com/_/wordpress/) elle-même
  - une base de données [MariaDB](https://hub.docker.com/_/mariadb/)
  - une interface [PhpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/), à brancher sur MariaDB

Nous ferons en sorte de pouvoir accéder aux fichiers de données (`/var/lib/mysql`) de MariaDB via un montage de volumes.

Comme pour les autres exercices, nous mettons à votre disposition un fichier `docker-compose.yml` à remplir avec les bonnes instructions.

Une fois votre `docker-compose.yml` finalisé, vous pouvez lancer la commande suivante pour démarrer tous les services :
```
docker-compose up
```

Pour vérifier que la base MariaDB est bien démarrée rendez-vous à la page [http://localhost:8080](http://localhost:8080).

Pour vérifier que votre site Wordpress est bien démarré et opérationnel, rendrez-vous à la page [http://localhost:8000](http://localhost:8000) et effectuez l'étape d'initialisation. Vous pourrez ensuite constater les changements sur la base de données via PhpMyAdmin.

Utiliser les commandes habituelles pour stopper et supprimer les conteneurs de l'exercice. Une fois les conteneurs supprimés, vous pourrez les recréer/redémarrer et constater que le contenu de site Wordpress a été conservé grâce à la persistence des données de la base MariaDB dans le volume correspondant.

*Note à propos des volumes :* Le répertoire de données utilisé par MariaDB (`.data` dans la solution) est créé avec les permissions de la machine invitée, il appartient donc à l'utilisateur **root**.  Idéalement, il faudrait donc le monter dans le répertoire `/var/lib...` de la machine hôte
