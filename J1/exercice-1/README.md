## Exercice n°1

L'application utilisée pour ce permier exercice est une page web NodeJS qui mémorise le nombre d'affichages dans une base de données Redis.

Cette application se compose donc :
- d'une application NodeJS utilisant le framework [Express](http://expressjs.com/)
- d'un conteneur Docker embarquant la base NoSQL [Redis](http://redis.io/)

L'ojectif de cette étape est de lancer les deux conteneurs et de les connecter ensemble via docker-cli :

*  Récupération et démarrage du conteneur redis :
```
  docker run -d --name redis redis
```

* Construction de l'image :
```
  docker build -t myrepo/nodeapp .
```

* Démarrage du conteneur de l'application sur le port 8000
```
  docker run -d --name nodeapp ##OptionPourLierCeConteneurARedis## ##OptionPourMapperLePortDuConteneur## mustard/nodeapp
```

Pour tester si votre application web NodeJS est bien connectée à Redis, vous pouvez consulter la page à l'adresse suivante : [http://[IP BASTION]:8000](http://localhost:8000)
