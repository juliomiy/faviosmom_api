/**
 * Created by juliomiyares on 10/30/16.
 */
'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");
var SqlString = require("sqlstring");

function Business_Detail() {
    this.get = function (req, res) {
        var sql;
        var response = {};
        var API = {"name": "businessdetail",
            "type": "get"
        };
        sql = "select location,closed_days,open_hours,current_location from business_detail";
        sql = SqlString.format(sql);
        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }

    this.location = function(req, res) {
        var response = {
            'statuscode': 200,
            'rows': 0,
            'api': 'business_detail',
            'result': null
        };

        response.rows = 1;

        var location = {
            "street" : "197 Benton Road",
            "city":  "Elizaville",
            "state": "New York",
            "zipcode": "12523"
        }
        response.result = [location];
        var t = test();
        utility.log('info', 'Business_Detail API',
            {
                "response": response
            });
        res.send(response);
    }

}

function test() {

}
module.exports = new Business_Detail();
