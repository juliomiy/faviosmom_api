'use strict';
module.change_code = 1;

var connection = require("../connection");
var SqlString = require('sqlstring');
var utility = require("../utility");

function MenuItems() {
    this.get = function (req, res) {
        var category = req.params['category'];
        var sql;
        var API = {"name":"menuitems", "type":"get"};
        var response = {};

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
                con.release();
                response = utility.formatSqlResponse(API,err,result);
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
        var API = {"name":"menuitems", "type":"post"};
        var new_menuItem = req['newMenuItem'];
        var response = {};

        if (!new_menuItem) {
            res.send(utility.formatErrorResponse(API));
            return;
        }
        connection.acquire(function (err, con) {

            sql = `insert into menu_items (menu_id,name, normalized_name,portion_size, price, available) \
                   values (?,?,?,?,?,?)`;
            sql = SqlString.format(sql,[new_menuItem.menu_id, new_menuItem.name,utility.normalize(new_menuItem.name),new_menuItem.portion_size,new_menuItem.price,new_menuItem.available]);
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });

    }

    this.updateMenuItem = function(req,res) {
        var sql;
        var API = {"name":"menuitems", "type":"put"};
        var menuItem = req['menuitem'];
        var response = {};
        if (!menuItem) {
            res.send(utility.formatErrorResponse(API));
            return;
        }
        var menuID = menuItem.menuid;
        var portionSize = menuItem.portionsize;
        var name = menuItem.name;
        var available = menuItem.available;
        var menuItemID = menuItem.menuitemid ;
        var price = menuItem.price;

        connection.acquire(function (err, con) {
            sql = "update menu_items set menu_id = ?, price = ?,portion_size = ?, name = ?, normalized_name = ?, available = ? where id = ? ";;
            sql = SqlString.format(sql,[menuID,price,portionSize,name,utility.normalize(name),available,menuItemID]);
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });

    }

    this.deleteMenuItem = function(req,res) {
        var sql;
        var API = {"name":"menuitems", "type":"delete"};
        var menuItemID = req['menuitemid'];
        var response = {};
            if (!menuItemID) {
            res.send(utility.formatErrorResponse(API));
            return;
        }
        connection.acquire(function (err, con) {
            sql = "delete from menu_items where id = ? LIMIT 1";
            sql = SqlString.format(sql,[menuItemID]);
            utility.log('info', 'MenuItem API',
                {
                    "sql": sql
                });
            con.query(sql, function (err, result) {
                con.release();
                response = utility.formatSqlResponse(API,err,result);
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
        var API = {"name":"menuitem", "type":"get"};
        var normalizedMenuItem = req.params.menuitem;
        var menuItemID = req.params.menuitemid;

        if (!(normalizedMenuItem || menuItemID )) {
            res.send(utility.formatErrorResponse(API));
            return;
        }
        connection.acquire(function (err, con) {
            if (menuItemID) {
                sql = `select id,menu_id,portion_size,name, price,normalized_name,vegetarian 
                     from menu_items where id = ? LIMIT 1`
                sql = SqlString.format(sql, [menuItemID]);
            } else {
                normalizedMenuItem = utility.normalize(normalizedMenuItem);
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

    this.getAlexaMenuItemsNames = function (req,res) {
        var sql;
        var API = {"name":"menuitem_alexa", "type":"get"};
        var response = {};
        connection.acquire(function (err, con) {
            sql = "select name from menu_items order by name desc";
            con.query(sql, function (err, result) {
               con.release();
               response = utility.formatSqlResponse(API,err,result);
               res.send(response);
            });
        });
    }
}



module.exports = new MenuItems();
