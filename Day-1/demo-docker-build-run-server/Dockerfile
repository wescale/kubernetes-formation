FROM node:10.2.0-alpine
RUN mkdir -p /usr/app
WORKDIR /usr/app
COPY build /usr/app
RUN npm install -g serve
EXPOSE 5000
CMD [ "serve", "-s", "/usr/app" ]