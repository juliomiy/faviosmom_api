/**
 * Created by juliomiyares on 10/30/16.
 */
'use strict';
module.change_code = 1;

var connection = require("../connection");
var utility = require("../utility");
var SqlString = require("sqlstring");

//TODO - refine responses for specific types of requests for business information
function Business_Detail() {
    this.get = function (req, res) {
        var sql;
        var response = {};
        var API = {"name": "businessdetail",
            "type": "get"
        };
        var detailType = req.params['detailtype'].toLowerCase();
        switch (detailType) {
            case "open":
                API.name += " open";
                sql = "select open_hours,closed_days from business_detail";
                break;
            case "location":
                API.name += " location";
                sql = "select location from business_detail";
                break;
            default:
                sql = "select location,closed_days,open_hours,current_location from business_detail";
        }
        sql = SqlString.format(sql);
        connection.acquire(function (err, con) {
            con.query(sql, function (err, result) {
                var result1 = {};
                con.release();
                switch (detailType) {
                    case "open":
                        var businessDetail = new Business_Detail()
                        businessDetail.isOpen(result[0]);
                        break;
                    case "location":

                }
                response = utility.formatSqlResponse(API,err,result);
                res.send(response);
            });
        });
    }

    Business_Detail.prototype.isOpen = function(result) {
       // var todayDate = new Date();
        var todayEST = new Date().toLocaleString("en-US", {timeZone: "America/New_York"})
        var todayESTDateString = todayEST.split(',')[0];
        var todayESTDateArray = todayESTDateString.split('/');
        var tmp = new Date(todayESTDateString);
        var day = tmp.getDay();

        var openHours = JSON.parse(result.open_hours);
        //var today = openHours["days"];
        var todayHours =  openHours['days'][day];
        var openingTime = todayHours[Object.keys(todayHours)[0]].open;
        var closingTime = todayHours[Object.keys(todayHours)[0]].close;

        var openingHourDigit = parseInt(openingTime);
        var closeHourDigit = parseInt(closingTime);

        if (openingTime.split(/\d/).join('') == 'pm')
            openingHourDigit +=12;


        if (closingTime.split(/\d/).join('') == 'pm')
            closeHourDigit +=15;

        //var closingTimeDate = new Date(todayDate.getFullYear(),todayDate.getMonth(),todayDate.getDate(),)

  //      debugger;

        day = new Date();
        var openTimeTodayUTC = new Date(todayESTDateArray[2],todayESTDateArray[0]-1,todayESTDateArray[1], openingHourDigit);

        var closeTimeTodayUTC = new Date(todayESTDateArray[2],todayESTDateArray[0]-1,todayESTDateArray[1], closeHourDigit);
        //var currentTimeTodayUTC = Date.UTC(today.getFullYear(), today.getMonth(), today.getDate(),today.getHours(),today.getMinutes());

      //  console.log("value of openhours " + openHours);
        if (closeTimeTodayUTC  > new Date() && openTimeTodayUTC < new Date())
           result.currently_open = true;
        else
            result.currently_open = false;

        return result;
    }

    this.location = function(result) {

        var response = {
            'statuscode': 200,
            'rows': 0,
            'api': 'business_detail',
            'result': null
        };

        response.rows = 1;

        var location = {
            "street" : "197 Benton Road",
            "city":  "Elizaville",
            "state": "New York",
            "zipcode": "12523"
        }
        response.result = [location];
        var t = test();
        utility.log('info', 'Business_Detail API',
            {
                "response": response
            });
        res.send(response);
    }

}

function test() {

}
module.exports = new Business_Detail();
