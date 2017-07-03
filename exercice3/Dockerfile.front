FROM node:7.7.4-alpine
RUN npm install -g serve
RUN mkdir -p /usr/app
WORKDIR /usr/app
COPY build /usr/app
EXPOSE 5000
CMD [ "serve", "-s /usr/app" ]

