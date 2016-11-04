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
            if (!category) {
                sql = SqlString.format('select mi.* from menu_items mi, menu m where mi.menu_id = m.id');
            } else if (category == "vegetarian") {
                sql = SqlString.format('select mi.* from menu_items mi where mi.vegetarian = 1');
            } else {
                var normalized_name = category.toLowerCase().replace(/\s/g,'');
                sql = SqlString.format('select * from menu_items where menu_id = (select id from menu where normalized_name = ?)', [normalized_name]);
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
    this.insertMenuItem = function (req,res) {
        var sql;
        var new_menuItem = req['newMenuItem'];
        var response = {};
        console.log(new_menuItem);
        connection.acquire(function (err, con) {

            sql = `insert into menu_items (menu_id,name, normalized_name,portion_size, price, available) \
                   values (?,?,?,?,?,?)`;
            sql = SqlString.format(sql,[new_menuItem.menu_id, new_menuItem.name,utility.normalize(new_menuItem.name),new_menuItem.portion_size,new_menuItem.price,new_menuItem.available]);
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse('menuitems POST',err,result);
                res.send(response);
            });
        });

    }

    this.updateMenuItem = function(req,res) {

    }

    this.deleteMenuItem = function(req,res) {

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
                sql = `select id,menu_id,portion_size,name, price,normalized_name,vegetarian 
                     from menu_items where id = ? LIMIT 1`
                sql = SqlString.format(sql, [menuItemID]);
            } else {
                normalizedMenuItem = normalizedMenuItem.toLowerCase().replace(/\s/g,'');
                sql = "select id,menu_id,portion_size,name, price,normalized_name,vegetarian from menu_items where id in  ( \
                    select id from menu_items where normalized_name = ? \
                       union select menuitem_id from phrase_to_menuitems where \
                        normalized = ?)";
                sql = SqlString.format(sql, [normalizedMenuItem,normalizedMenuItem]);
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
