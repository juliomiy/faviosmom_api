/**
 * Created by juliomiyares on 10/23/16.
 */
'use strict';
module.change_code = 1;
var SqlString = require('sqlstring');
var utility = require('../utility');
var connection = require("../connection");
/*
Save an order to the database.
Order Field is stored as json in a json field of the order table
 {"order": [
     {
     "name": "Black Beans",
     "menu_id": 456,
     "portion": "pot",
     "price": "25" }
     ],
 "total_order_price": "27.56"
 }
 */
function Order() {
    this.post = function (req, res) {
        var sql, order, total_order_price = 0, orderID;
        var API = {"name": "order",
                   "type": "post"};
        var response = {};

        console.log(JSON.stringify(req));
        connection.acquire(function (err, con) {
            if (null !== req['order'] && req['order']) {
                order = req['order'];
                //calculate total order price
                for (var i=0; i<order.length;i++) {
                    total_order_price += order[i].portions * order[i].price;
                }
            }
            //total_order_price = req['total_order_price'];
            //TODO Create method to create Order ID which is returned back to the invoker of the
            orderID = Math.floor(Date.now());
            sql = SqlString.format("insert into faviosmom.order (`order`,`total_order_price`,`orderID`) values (?,?,?)",[JSON.stringify(order),total_order_price,orderID]);
            utility.log('info', 'Order API', {
                "sql": sql
            });
            con.query(sql, function(err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                response['result']['orderID'] = orderID;
                utility.log('info', 'Order API', {
                    "response": response
                });
                res.send(response);
            })
        });
    }
};
module.exports = new Order();