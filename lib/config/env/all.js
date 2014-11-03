'use strict';

var path = require('path');

var rootPath = path.normalize(__dirname + '/../../..');

module.exports = {
  root: rootPath,
  port: process.env.PORT || 3000,
  mongo: {
    options: {
      db: {
        safe: true
      }
    }
  },

  // smtp: {
  //   host: "smtpcloud.sohu.com",
  //   // secureConnection: true,
  //   port: 25,
  //   auth: {
  //       user: "postmaster@ijse.sendcloud.org",
  //       pass: "K7NCKP4G"
  //   }
  // }
  smtp: {
  	host: "smtp.mailgun.org",
  	// secureConnection: true,
  	port: 25,
  	auth: {
  	    user: "postmaster@mg.ijser.cn",
  	    pass: "!@#$%^&QWERTYUasdfghj"
  	}
  }

};