const express = require('express');
const app = express();
app.get('', (request, response) => {
    return response.send('OK');
});
app.listen(80);
