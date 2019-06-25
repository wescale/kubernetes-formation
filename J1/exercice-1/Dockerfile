FROM node:4

MAINTAINER Rémy Méja <remy.meja@inist.fr>
MAINTAINER Claude Niederlender <claude.niederlender@inist.fr>

RUN mkdir /usr/src/my-app
WORKDIR /usr/src/my-app
COPY app.js .
COPY package.json .
RUN npm install

EXPOSE 8080

CMD ["node", "app.js"]
