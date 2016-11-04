/**
 * Created by juliomiyares on 10/25/16.
 */
'use strict';
module.change_code = 1;
var winston = require('winston');
winston.add(
    winston.transports.File, {
        filename: 'faviosmom-api.log',
        level: 'info',
        json: true,
      //  eol: 'n', // for Windows, or `eol: ‘n’,` for *NIX OSs
        timestamp: true
    }
)
function Utility() {
      this.log = function(log_level, section, key_value) {
           winston.log(log_level,section,key_value);
      }

      this.formatSqlResponse = function(api,err,result) {
          var response = {
              'statuscode': 200,
              'rows': 0,
              'api': api.name + " " + api.type,
              'result': {}
          };

          if (!err) {
              var rows = 0;

              switch (api.type) {

                  case "post":
                      response['result'] = JSON.parse( '{"id" :' + result.insertId + '}' );
                  case "put":
                  case "delete":

                  default:
                    response['rows'] = result.affectedRows;
                    break;
                  case "get":
                      response['rows'] = result.length;
                      response['result'] = result;
                      break;
              }
          } else {
              response['statuscode'] = 500;
              response['result'] = err;
          }console.log(response);
          return response;
      }
      this.formatErrorResponse = function(API) {
        var response = {
            'statuscode': 500,
            'rows': 0,
            'api': API.name + " " + API.type,
            'result': {}
        };
        return response;
     }
      this.normalize = function(str) {
          return str.replace(/[\W_+\d]/g, "");
      }
}


module.exports = new Utility();
