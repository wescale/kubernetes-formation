#!/bin/bash

sudo apt-get -y install nodejs npm
sudo npm install -g create-react-app

sudo ln -s /usr/bin/nodejs /usr/bin/node

create-react-app app

