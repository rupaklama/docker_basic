const express = require('express');
const redis = require('redis');
const process = require('process');

const app = express();

// connection to redis server
const client = redis.createClient({
    // add redis's container name form docker-compose.yml 
    // to specify where Redis server is running
    host: 'redis-server',
    port: 6379
});
// initialize number of visits to 0
client.set('visits', 0);

app.get('/', (req, res) => {
    // using redis client server to count url visits
    // number of visits are store inside redis
    // process.exit(0); test to shutdown server
    client.get('visits', (err, visits) => {
        res.send('Number of visits is ' + visits)

        // update number of visits, visits is string by default
        client.set('visits', parseInt(visits) + 1)
    })
});

const PORT = 4000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}!`));

