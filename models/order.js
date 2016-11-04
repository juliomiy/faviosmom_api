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
                var response = {"statuscode": 200,
                    "rows": 0,
                    "api": 'order',
                    "result": {
                        "orderID": orderID,
                        "total_order_price": total_order_price
                    }
                };
                con.release();
                if (!err) {
                    response['rows'] = 1;
                    response['result']['orderID'] = orderID;
                    //response['result'] = result;
                } else {
                    response['statuscode'] = 500;
                    response['result'] = null;
                }
                utility.log('info', 'Order API', {
                    "response": response
                });
                res.send(response);
            })
        });
    }
};
module.exports = new Order();