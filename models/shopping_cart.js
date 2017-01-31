/**
 * Created by jmiyares on 12/3/16.
 */
'use strict';
module.change_code = 1;
var SqlString = require('sqlstring');
var utility = require('../utility');
var connection = require("../connection");

function Shopping_Cart() {
    this.get = function (req, res) {
        var sql;
        var response = {};
        var API = {
            "name": "shopping_cart",
            "type": "get"
        };
        var sessionID = req.params.sessionid;

        sql = "select mi.photo_url,mi.name, sc.menuID,sc.quantity,mi.price,mi.price*sc.quantity as subtotal from shopping_cart sc, menu_items mi where sc.sessionID = ? and sc.menuID =mi.id"
        sql = SqlString.format(sql,[sessionID]);
        console.log(sql);
        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }

    this.clearCart = function (req,res) {
        var sql;
        var response = {};
        var API = {"name": "shopping_cart_clear",
            "type": "post"
        };
        sql = "delete from shopping_cart where sessionID = ?";
        sql = SqlString.format(sql,[sessionID]);
        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }

    this.addToCart = function(req,res) {
        var sql;
        var response = {};
        var API = {"name": "shopping_cart_add",
            "type": "post"
        };
        //post variables
        var sessionID = req('sessionID');
        var add_menuItemID = req['menuitemid'];
        var quantity = req['quantity'];

        //does user already have a Cart?

        //If they do, check if menuItem already in cart and only a change in quantity


    }

    this.updateCart = function(req,res) {
        var sql;
        var response = {};
        var API = {"name": "shopping_cart_update",
            "type": "post"
        };
    }

    this.deleteFromCart = function(req,res) {
        var sql;
        var response = {};
        var API = {"name": "shopping_cart_delete",
            "type": "post"
        };
    }
}

module.exports = new Shopping_Cart();