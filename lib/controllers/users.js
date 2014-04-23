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
exports.activate = function(req, res, next) {
  var newUser = new User(req.body);
  User.findOne({
    "email": newUser.email
  }, function(err, user) {
    user.password = newUser.password;
    user.group = newUser.group;
    user.name = newUser.name;
    user.receivers = newUser.receivers;
    user.status = "1";
    user.save(function(err) {
      if (err) return res.json(404, err);
      req.logIn(newUser, function(err) {
        if (err) return next(err);
        return res.json(req.user.userInfo);
      });
    });
  });
};

/**
 * Get current user
 */
exports.me = function(req, res) {
  res.json(req.user || null);
};

/**
  *Find user by code
  */
exports.findByCode = function(req,res,next){
  var code = req.query.code;
  User.findById(code,function(err,result){
    if (err) return res.json({err:"illegal user"});
    if (!result) return res.json({err:"illegal user"});
    return res.json({email:result.email,code:code,status:result.status});
  });
};
 

/**
 * Add user
 */
function saveUser(user, callback) {
  user.save(function(err) {
    callback(err);
  });
}

exports.addUser = function (req, res) {
  var newUser = new User(req.body);
  newUser.hashedPassword = "fdsafdsafdsafsdf";
  newUser.provider = "local";
  saveUser(newUser, function(err){
    if (err) return res.json(400, err);
    return res.json({msg: "success"});
  });
};

exports.addAllNew = function (req, res) {
  var nameList = req.body.nameList.split(",");
  var emailSuffix = req.body.emailSuffix;

  for(var i in nameList) {

    var name = nameList[i].trim();
    if(name === "" || typeof name === 'undefined') return res.json("error");


    var newUser = new User();
    newUser.name = name;
    newUser.email = name + emailSuffix;

    saveUser(newUser, function(err){
      if (err) return res.json(400, err);
    });
  }

  return res.json({msg: "success"});
};
/**
  * Send RegistEmail
  */
exports.sendRegistEmail = function(req, res) {
  var userId = req.params.id;
  User.findById(userId, function (err, user) {
    Emailer.sendRegistEmail(user, function(err, response){
      if(err) {
        //console.log(500, err);
        return res.json({msg: "error"});
      } else {
        return res.json({msg: "success"});
      }
    });
  });
};
 