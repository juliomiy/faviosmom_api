'use strict';
module.change_code = 1;

var config = require('config').get('Faviosmom');
console.log('NODE_ENV: ' + config.util.getEnv('NODE_ENV'));

var express = require('express');
var bodyparser = require('body-parser');
var connection = require('./connection');
var routes = require('./routes');
var fs = require('fs');
var https = require('https');
var utility = require('./utility');
var debug = require('debug')('faviosmom-api')  
var  name = 'faviosmom-api'  
debug('booting %s', name)

var winston = require('winston')

var app = express();
app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());

var options = {
    key  : fs.readFileSync('faviosmom.key'),
    cert : fs.readFileSync('faviosmom.crt')
};

connection.init();
routes.configure(app);

var PORT = config.get('webConfig.port');

//https.createServer(options, app).listen(PORT, function () {
//    console.log('Started!');
//});

var server = app.listen(PORT, function() {
  console.log('Server listening on port ' + server.address().port);
});
