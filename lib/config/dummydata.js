'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User'),
  Article = mongoose.model('Article'),
  Report = mongoose.model('Report');

/**
 * Populate database with sample application data
 */
var dummydata = function(done) {
  Report.find({}).remove(function() {
    console.log('finished populating reports');
  });

  Article.find({}).remove(function(){
    Article.create({
      subject: "分享一",
      content: "fd双方都桑"
    });
  });
  // Clear old users, then add a default user
  User.find({}).remove(function() {
    User.create({
      provider: 'local',
      name: 'Test User',
      email: 'test@test.com',
      password: 'test',
      status: '0'
    }, function() {
        console.log('finished populating users');
        if (done) {
          done();
        }
      }
    );
    User.create({
      provider: 'local',
      name: '迟晓靓',
      email: 'cxj_liang@126.com',
      password: '123456',
      status: '0'
    }, function() {
        console.log('finished populating users');
        if (done) {
          done();
        }
      }
    );
  });
};

exports = module.exports = dummydata;
