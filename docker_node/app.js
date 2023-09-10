const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Example node app');
});

app.get('/:name', (req, res) => {
    res.send("Hello " + req.params.name);
});

app.listen(5000, () => {
    console.log('Example app listening on port 5000!');
})