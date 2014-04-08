'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User'),
  Report = mongoose.model('Report');

/**
 * Populate database with sample application data
 */
var dummydata = function(done) {
  Report.find({}).remove(function() {
    console.log('finished populating reports');
  });

  // Clear old users, then add a default user
  User.find({}).remove(function() {
    User.create({
      provider: 'local',
      name: 'Test User',
      email: 'cxj_liang@126.com',
      password: 'test',
      status: '0'
    }, function() {
        console.log('finished populating users');
        if (done) {
          done();
        }
      }
    );
  });
}

exports = module.exports = dummydata;
