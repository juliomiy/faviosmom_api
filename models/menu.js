'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");
var SqlString = require("sqlstring");

function Menu() {
    this.get = function (req, res) {
        var sql;
        var response = {};
        var API = {"name": "menu",
                   "type": "get"
        };
        var type = req.params.type;

        if (type) {
            sql = SqlString.format('select mi.id, mi.name, mi.normalized_name from menu_items mi where  id in (select menuitem_id from type_to_menuitems where type = ? and available = 1)',[type]);
        } else {
            sql = SqlString.format('select id,short_description,name,normalized_name from menu where available=1');
        }

        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                if (!err) {
                    response = utility.formatSqlResponse(API,err,result);
                    response['result'] = result;
                } else {
                    response['statuscode'] = 500;
                }
                res.send(response);
            });
        });
    }
}


 module.exports = new Menu();
