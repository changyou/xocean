'use strict';

angular.module('xoceanApp')
  .factory('Auth', function Auth($location, $rootScope, Session, User, $cookieStore) {

    // Get currentUser from cookie
    $rootScope.currentUser = $cookieStore.get('user') || null;
    if($rootScope.currentUser) {
      $rootScope.currentUser.name = decodeURI($rootScope.currentUser.name);
    }
    $cookieStore.remove('user');

    return {

      /**
       * Authenticate user
       *
       * @param  {Object}   user     - login info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      login: function(user, callback) {
        var cb = callback || angular.noop;

        return Session.save({
          email: user.email,
          password: user.password
        }, function(user) {
          $rootScope.currentUser = user;
          return cb();
        }, function(err) {
          return cb(err);
        }).$promise;
      },

      /**
       * Unauthenticate user
       *
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      logout: function(callback) {
        var cb = callback || angular.noop;

        return Session.delete(function() {
            $rootScope.currentUser = null;
            return cb();
          },
          function(err) {
            return cb(err);
          }).$promise;
      },

      /**
       * Create a new user
       *
       * @param  {Object}   user     - user info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      createUser: function(user, callback) {
        var cb = callback || angular.noop;

        return User.save(user,
          function(user) {
            $rootScope.currentUser = user;
            return cb(user);
          },
          function(err) {
            return cb(err);
          }).$promise;
      },

      /**
       * Change password
       *
       * @param  {String}   oldPassword
       * @param  {String}   newPassword
       * @param  {Function} callback    - optional
       * @return {Promise}
       */
      changePassword: function(oldPassword, newPassword, callback) {
        var cb = callback || angular.noop;

        return User.update({
          oldPassword: oldPassword,
          newPassword: newPassword
        }, function(user) {
          return cb(user);
        }, function(err) {
          return cb(err);
        }).$promise;
      },

      /**
       * Gets all available info on authenticated user
       *
       * @return {Object} user
       */
      currentUser: function() {
        return User.get();
      },

      /**
       * Simple check to see if a user is logged in
       *
       * @return {Boolean}
       */
      isLoggedIn: function() {
        var user = $rootScope.currentUser;
        return !!user;
      },
      /**
       * Activate a user
       *
       * @param  {Object}   user     - user info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      activateUser: function(user, callback) {
        var cb = callback || angular.noop;
        return User.activate(user,
          function(user) {
            $rootScope.currentUser = user;
            return cb(user);
          },
          function(err) {
            return cb(err);
          }).$promise;
      },
      /**
       * check code before Activate a user
       *
       * @param  {String}   code     - unique code
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      preActivateUser: function(code, callback) {
        var cb = callback || angular.noop;
        return User.findByCode(code,
          function(user) {
            // $rootScope.currentUser = user;
            return (user);
          },
          function(err) {
            return cb(err);
          });
      },
      /**
       * Change user info
       *
       * @param  {Object}   user     - user info
       * @param  {Function} callback - optional
       * @return {Promise}
       */
      changeInfo: function(user, callback) {
        var cb = callback || angular.noop;
        return User.changeInfo(user,
          function(user) {
            $rootScope.currentUser = user;
            return cb(user);
          },
          function(err) {
            return cb(err);
          }).$promise;
      }
    };
  });