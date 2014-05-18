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
    });
    User.create({
      provider: 'local',
      name: '迟晓靓',
      email: 'cxj_liang@126.com',
      password: '123456',
      status: '0'
    });
    User.create({
      provider: 'local',
      name: '周淑枫',
      email: 'zhoushufeng@cyou-inc.com',
      password: '123456',
      status: '0'
    });
    User.create({
      provider: 'local',
      name: '刘剑锋',
      email: '444984@qq.com',
      password: '123456',
      status: '0'
    });
  });
};

exports = module.exports = dummydata;
