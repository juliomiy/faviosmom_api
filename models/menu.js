'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");

function Menu() {
    this.get = function (res) {
        var sql = 'select id,short_description,name,normalized_name from menu where available=1';

        utility.log('info', 'Menu API', {
            "sql": sql
        });

        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                var response = {
                    'statuscode': 200,
                    'rows': 0,
                    'api': 'menu',
                    'result': null
                };
                con.release();
                if (!err) {
                    response['rows'] = result.length;
                    response['result'] = result;
                } else {
                    response['statuscode'] = 500;
                }
                utility.log('info', 'Menu API', {'response': response});
                res.send(response);
            });
        });
    }
}


 module.exports = new Menu();
