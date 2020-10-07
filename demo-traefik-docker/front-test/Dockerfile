FROM node:8.11-alpine
RUN npm install -g serve
RUN mkdir -p /usr/app
WORKDIR /usr/app
COPY build /usr/app
EXPOSE 5000
CMD [ "serve" ]

