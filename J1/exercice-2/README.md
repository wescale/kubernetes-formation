## Exercice n°2 : Heureusement, il y a docker-compose

Nous utilisons la même application web NodeJS utilisée pour le premier exercice.

L'ojectif de cette étape est de lancer les deux conteneurs et de les connecter ensemble, non plus avec docker-cli mais avec un fichier docker-compose.yml.

Pour cela, nous mettons à votre disposons un fichier docker-compose.yml a remplir avec les bonnes instructions.

Il faudra indiquer pour le service web relatif à notre application NodeJS, de construire l'image à partir de son Dockerfile et de la lier au service redis. Pour le service redis, il suffit simplement de lui indiquer de se baser sur son image officielle présente sur [Dockerhub](https://hub.docker.com/).

Une fois votre docker-compose.yml finalisé, vous pouvez lancer la commande suivante pour démarrer tous les services :
```
docker-compose up -d
```


Pour tester si votre application web NodeJS est bien connectée à Redis, vous pouvez consulter la page à l'adresse suivante : [http://localhost:8000](http://localhost:8000)
Pour stopper tous les conteneurs liés aux services décrits dans docker-compose, vous pouvez lancer la commande suivante :
```
docker-compose stop
```
Et pour les supprimer
```
docker-compose rm
```
