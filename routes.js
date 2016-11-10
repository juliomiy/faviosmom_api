'use strict';

var menuItem = require('./models/menu_item');
var menu = require('./models/menu');
var order = require('./models/order');
var businessDetail = require('./models/business_detail');

module.exports = {
  configure: function(app) {
    app.get('/v1/menu/:type?', function(req, res) {
      menu.get(req, res);
    });

    app.post('/v1/menu/', function(req, res) {
      menu.insertMenu(req.body, res);
    });

    app.put('/v1/menu/', function(req, res) {
      menu.updateMenu(req, res);
    });

    app.delete('/v1/menu/', function(req, res) {
      menu.deleteMenu(req.body, res);
    });

    app.get('/v1/menuitems/alexa/', function (req,res) {
          menuItem.getAlexaMenuItemsNames(req,res);;
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

   app.post('/v1/menuitem/', function (req,res) {
       menuItem.insertMenuItem(req.body,res);
   });

   app.put('/v1/menuitem/', function (req,res) {
       menuItem.updateMenuItem(req,res);
   });

   app.delete('/v1/menuitem/', function (req,res) {
       menuItem.deleteMenuItem(req.body,res);

   });

   app.get('/v1/businessdetail/:detailtype?', function(req,res) {
          businessDetail.get(req,res);
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
