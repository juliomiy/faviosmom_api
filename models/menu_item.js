'use strict';
module.change_code = 1;

var connection = require("../connection");
var SqlString = require('sqlstring');
var utility = require("../utility");

function MenuItems() {
    this.get = function (req, res) {
        var category = req.params['category'];
        var sql;
        console.log(req.params);
        connection.acquire(function (err, con) {
            if (category == null) {
                sql = SqlString.format('select mi.* from menu_items mi, menu m where mi.menu_id = m.id');
            } else if (category == "vegetarian") {
                sql = SqlString.format('select mi.* from menu_items mi where mi.vegetarian = 1');
            } else {
                sql = SqlString.format('select * from menu_items where menu_id = (select id from menu where normalized_name = ?)', [category]);
            }
            utility.log('info', 'MenuItems API',
                {
                    "sql": sql
                });

            con.query(sql, function (err, result) {
                var response = {
                    'statuscode': 200,
                    'rows': 0,
                    'api': 'menuitems',
                    'result': null
                };
                con.release();
                if (!err) {
                    response['rows'] = result.length;
                    response['result'] = result;
                } else {
                    response['statuscode'] = 500;
                }
                utility.log('info', 'MenuItems API',
                    {
                        "response": response
                    });
                res.send(response);
            });
        });
    }
    /*
    Get individual Menu item from the menu_items table using either normalized name or menu_id (integer)
    responds with json record containing the details of the menu item
    TODO initially, will use the normalized Name of the menu item for lookup though should also include
    more sophisticated full text search or lookup via the unique key for the menu item.
     */
    this.getMenuItem = function(req,res) {
        var sql;
        var normalizedMenuItem = req.params.menuitem;
        var menuItemID = req.params.menuitemid;

        connection.acquire(function (err, con) {
            if (menuItemID) {
                sql = SqlString.format('select id,menu_id,portion_size,name, price,normalized_name,vegetarian from menu_items where id = ? LIMIT 1', [menuItemID]);
            } else {
                sql = SqlString.format('select id,menu_id,portion_size,name, price,normalized_name,vegetarian from menu_items where normalized_name = ? LIMIT 1', [normalizedMenuItem]);
            }
            utility.log('info', 'MenuItem API',
                {
                    "sql": sql
                });
            con.query(sql, function (err, result) {
                var response = {
                    'statuscode': 200,
                    'rows': 0,
                    'api': 'menuitem',
                    'result': null
                };
                con.release();
                if (!err) {
                    response['rows'] = result.length;
                    response['result'] = result;
                } else {
                    response['statuscode'] = 500;
                }
                utility.log('info', 'MenuItem API',
                    {
                        "response": response
                    });
                res.send(response);
            });
        });
    };
}



module.exports = new MenuItems();
