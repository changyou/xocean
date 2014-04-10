'use strict';

var mongoose = require('mongoose'),
    User = mongoose.model('User'),
    Emailer = require('../modules/sendmail'),
    passport = require('passport');

/**
 * Create user
 */
exports.create = function (req, res, next) {
  var newUser = new User(req.body);
  newUser.provider = 'local';
  newUser.save(function(err) {
    if (err) return res.json(400, err);

    req.logIn(newUser, function(err) {
      if (err) return next(err);

      return res.json(req.user.userInfo);
    });
  });
};

/**
 *  Get profile of specified user
 */
exports.show = function (req, res, next) {
  var userId = req.params.id;

  User.findById(userId, function (err, user) {
    if (err) return next(err);
    if (!user) return res.send(404);

    res.send({ profile: user.profile });
  });
};

/**
 *  Get all user
 */
exports.getAll = function (req, res, next) {
  var userId = req.params.id;

  User.find( {}, function (err, result) {
    if (err) return next(err);
    if (!result) return res.send(404);
    res.json(result);
  });
};

/**
 * Change password
 */
exports.changePassword = function(req, res, next) {
  var userId = req.user._id;
  var oldPass = String(req.body.oldPassword);
  var newPass = String(req.body.newPassword);

  User.findById(userId, function (err, user) {
    if(user.authenticate(oldPass)) {
      user.password = newPass;
      user.save(function(err) {
        if (err) return res.send(400);

        res.send(200);
      });
    } else {
      res.send(403);
    }
  });
};

/**
 * Activate user
 */
exports.activate = function (req, res, next) {
  var newUser = new User(req.body);
  User.findOneAndUpdate({"email":newUser.email},{ $set: {
    group: newUser.group,
    name:newUser.name,
    password:newUser.password,
    receivers:newUser.receivers
  }}, function (err, user) {
    if (err) return res.json(404, err);
    res.send(200);
  });
};

/**
 * Get current user
 */
exports.me = function(req, res) {
  res.json(req.user || null);
};


exports.sendRegistEmail = function(req, res) {
  var userId = req.params.id;
  User.findById(userId, function (err, user) {
    Emailer.sendRegistEmail(user, function(err, response){
      if(err) {
        return res.json(500, err);
      } else {
        res.json({success: true});
      }
    });
  });
};

/**
  *Find user by code
  */
exports.findByCode = function(req,res,next){
  var code = req.query.code;
  User.findOne({code:code},function(err,result){
    if (err) return res.json({err:"illegal user"});
    if (!result) return res.json({err:"illegal user"});
    return res.json({email:result.email,code:code});
  });
};

