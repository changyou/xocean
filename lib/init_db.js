
var fs = require('fs'),
	path = require('path'),
	mongoose = require('mongoose');

var config = require('./config/config');

// Connect to database
var db = mongoose.connect(config.mongo.uri, config.mongo.options);

// Bootstrap models
var modelsPath = path.join(__dirname, 'models');
fs.readdirSync(modelsPath).forEach(function (file) {
  if (/(.*)\.(js$|coffee$)/.test(file)) {
    require(modelsPath + '/' + file);
  }
});

// Populate empty DB with sample data
if(process.env.NODE_ENV != "test") require('./config/dummydata')();
