FROM node:4

MAINTAINER Akram BLOUZA <akram.blouza@wescale.fr>
MAINTAINER Claude Niederlender <claude.niederlender@inist.fr>

RUN mkdir -p /usr/src/my-app
RUN mkdir -p /usr/src/my-app/client
WORKDIR /usr/src/my-app
COPY app.js .
COPY client/index.html .
COPY package.json .
RUN npm install

EXPOSE 8080

CMD ["node", "app.js"]
