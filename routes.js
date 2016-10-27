'use strict';

var menuItem = require('./models/menu_item');
var menu = require('./models/menu');
var order = require('./models/order');

module.exports = {
  configure: function(app) {
    app.get('/v1/menu/', function(req, res) {
      menu.get(res);
    });

    app.get('/v1/menuitems/:category?', function(req, res) {
          menuItem.get(req, res);
    });

   app.get('/v1/menuitems/:category?', function(req, res) {
      menuItem.get(req, res);
    });

   app.get('/v1/menuitem/:menuitemid(\\d+)', function(req,res) {
          menuItem.getMenuItem(req,res);
   });

   app.get('/v1/menuitem/:menuitem', function(req,res) {
      menuItem.getMenuItem(req,res);
   });

    app.post('/v1/order/', function (req, res) {
      console.log(req.toString());
      order.post(req.body, res);
    });

//    app.get('/menuitems/', function(req, res) {
//      menuItem.get(req, res);
//    });

/* 
    app.post('/todo/', function(req, res) {
      todo.create(req.body, res);
    });
 
    app.put('/todo/', function(req, res) {
      todo.update(req.body, res);
    });
 
    app.delete('/todo/:id/', function(req, res) {
      todo.delete(req.params.id, res);
    });
*/
  }
};
