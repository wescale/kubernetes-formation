FROM node:14

LABEL maintainer="Wescale Formation <training@wescale.fr>"

RUN mkdir /usr/src/my-app
WORKDIR /usr/src/my-app
COPY app.js .
COPY package.json .
RUN npm install

EXPOSE 8080

CMD ["node", "app.js"]
