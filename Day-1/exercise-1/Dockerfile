FROM node:19.1.0-alpine

LABEL maintainer="Wescale Formation <training@wescale.fr>"

# Create the directory /usr/src/my-app
RUN mkdir -p /usr/src/my-app

# Change the current directory to /usr/src/my-app
WORKDIR /usr/src/my-app
# Copy the file app.js to the current directory
COPY app.js .
# Copy the file package.json to to the current directory
COPY package.json .
# Execute the command: npm install
RUN npm install

EXPOSE 8080

CMD ["node", "app.js"]
