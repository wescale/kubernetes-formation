'use strict';

const bluebird = require('bluebird'),
      express = require('express'),
      app = express(),
      redis = require("redis"),
      client = redis.createClient({host: "redis"}),
      PORT = 8080;

bluebird.promisifyAll(redis.RedisClient.prototype);

app.get('/', (req, res) => {
  client.incrAsync('hits').then((result) => {
    res.send('Hello everyone! I have processed ' + result + ' requests.\n');
  })
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
