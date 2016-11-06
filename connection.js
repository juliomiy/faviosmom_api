var config = require('config').get('Faviosmom');
var mysql = require('mysql');
 
function Connection() {
  this.pool = null;
  this.dbHost = config.get('dbConfig.host');
  this.user = config.get('dbConfig.user');
  this.dbName = config.get('dbConfig.dbName');
  this.password = config.get('dbConfig.password');
  this.connectionLimit = config.get('dbConfig.connectionLimit');

  this.init = function() {
    this.pool = mysql.createPool({
      connectionLimit: this.connectionLimit,
      host: this.dbHost,
      user: this.user,
      password: this.password,
      database: this.dbName,
      multipleStatements: true
    });
  };
 
  this.acquire = function(callback) {
    this.pool.getConnection(function(err, connection) {
      callback(err, connection);
    });
  };
}
 
module.exports = new Connection();
