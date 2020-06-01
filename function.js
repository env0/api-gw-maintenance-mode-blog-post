'use strict';

exports.handler =  async function(event, context, callback) {
    console.log("EVENT: \n" + JSON.stringify(event, null, 2));
    console.log("CONTEXT: \n" + JSON.stringify(context, null, 2));
    const res = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
        }
    };
    callback(null, res);
};
