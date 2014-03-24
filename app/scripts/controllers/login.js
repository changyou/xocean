'use strict';

angular.module('xoceanApp')
  .controller('LoginCtrl', function ($scope, Auth, $location) {
    $scope.user = {
      email: 'test@test.com',
      password: 'test'
    };
    $scope.errors = {};

    $scope.login = function(form) {
      $scope.errors.other = "";
      $scope.submitted = true;

      if(form.$valid) {
        Auth.login({
          email: $scope.user.email,
          password: $scope.user.password
        })
        .then( function() {
          // Logged in, redirect to home
          $location.path('/');
        })
        .catch( function(err) {
          err = err.data;
          $scope.errors.other = err.message;
        });
      }
    };
  });