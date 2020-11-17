FROM node:14.15-alpine

RUN mkdir -p /usr/app

COPY public /usr/app/public
COPY src /usr/app/src
COPY package.json package-lock.json /usr/app/

WORKDIR /usr/app
RUN npm install && npm run build
WORKDIR /usr/app/build
RUN npm install -g serve

EXPOSE 5000
CMD [ "serve" ]

