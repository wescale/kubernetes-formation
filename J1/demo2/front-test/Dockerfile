FROM node:8.11.2-alpine
RUN mkdir -p /usr/app
WORKDIR /usr/app
COPY build /usr/app
RUN npm install -g serve
EXPOSE 3000
CMD [ "serve" ]
