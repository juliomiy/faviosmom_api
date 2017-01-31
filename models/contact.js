/**
 * Created by jmiyares on 11/16/16.
 */
'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");
var SqlString = require("sqlstring");

function Contact() {
    this.insertContact = function (req,res) {
        var sql;
        var response = {};
        var API = {"name": "contact",
            "type": "post"
        };
   //     var data = req['data'];

 /*       var menu = req['menu'];
        if (!menu) {
            res.send(utility.formatErrorResponse(API));
            return;
        }
*/
        var name = req.body.name;
        var phone = req.body.phone;
        var email = req.body.email;
        var message = req.body.message;
//console.log(JSON.stringify(data));
        sql = "insert into contact (name,phone,email,message) values (?,?,?,?)";
        sql = SqlString.format(sql,[name,phone,email,message]);

        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }
}

module.exports = new Contact();