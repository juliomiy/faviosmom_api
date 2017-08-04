'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");
var SqlString = require("sqlstring");

/**
 * @author juliomiyares@mac.com (Julio Hernandez-Miyares)
 * Menu data object that operates on the menu table
 */
function Menu() {
    this.get = function (req, res) {
        var sql;
        var response = {};
        var API = {"name": "menu",
                   "type": "get"
        };
        var type = req.params.type;

        /* type can be a category or empty. If empty, responds with all of the menu items that are available */
        if (type) {
            sql = SqlString.format('select mi.id, mi.one_liner,mi.short_description,mi.name, mi.normalized_name from menu_items mi where  id in (select menuitem_id from type_to_menuitems where type = ? and available = 1)',[type]);
        } else {
            sql = SqlString.format('select id,one_liner,short_description,name,normalized_name from menu where available=1');
        }

        connection.acquire(function (err, con) {
            if (err) throw err;
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }
    this.updateMenu = function (req,res) {

    }

    this.insertMenu = function (req,res) {
        var sql;
        var response = {};
        var API = {"name": "menu",
            "type": "post"
        };

        var menu = req['menu'];
        if (!menu) {
            res.send(utility.formatErrorResponse(API));
            return;
        }

        var name = menu.name;
        var normalized_name = utility.normalize(name);
        var short_description = menu.short_description;
        var long_description = menu.long_description;
        var available = menu.available;

        sql = "insert into menu (name,normalized_name,available,short_description,long_description) values (?,?,?,?,?)";
        sql = SqlString.format(sql,[name,normalized_name,available,short_description,long_description]);

        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }

    this.deleteMenu = function (req,res) {
        var sql;
        var response = {};
        var API = {"name": "menu",
            "type": "delete"
        };
        var menuID = req['menuid'];
        if (!menuID) {
            res.send(utility.formatErrorResponse(API));
            return;
        }

        sql = "delete from menu where id = ? LIMIT 1";
        sql = SqlString.format(sql,[menuID]);
        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }
}


 module.exports = new Menu();
