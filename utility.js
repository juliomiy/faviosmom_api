/**
 * Created by juliomiyares on 10/25/16.
 */
'use strict';
module.change_code = 1;
var winston = require('winston');

function Utility() {
      this.log = function(log_level, section, key_value) {
           winston.log(log_level,section,key_value);
      }
}

module.exports = new Utility();
