'use strict';
module.change_code = 1;

var config = require('config').get('Faviosmom');
console.log('NODE_ENV: ' + config.util.getEnv('NODE_ENV'));

var express = require('express');
var bodyparser = require('body-parser');
var connection = require('./connection');
var routes = require('./routes');

var debug = require('debug')('faviosmom-api')  
var  name = 'faviosmom-api'  
debug('booting %s', name)

var winston = require('winston')

winston.log('info', 'Hello log files!', {  
  someKey: 'some-value'
})
 
var app = express();
app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());
 
connection.init();
routes.configure(app);

var PORT = config.get('webConfig.port');

var server = app.listen(PORT, function() {
  console.log('Server listening on port ' + server.address().port);
});
