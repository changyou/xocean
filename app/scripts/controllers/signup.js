'use strict';

angular.module('xoceanApp')
  .controller('SignupCtrl', function ($scope, Auth, $location, id, $timeout) {
    if(id){
      $scope.user = Auth.preActivateUser({"code":id});
    }else{
      $scope.user = {};
    }
    
    $scope.errors = {};

    $scope.register = function(form) {
      $scope.submitted = true;
  
      if(form.$valid) {
        Auth.activateUser({
          name: $scope.user.name,
          email: $scope.user.email,
          password: $scope.user.password,
          group: $scope.user.group,
          receivers: ($scope.user.receivers),
          code: $scope.user.code,
          jobNumber: $scope.user.jobNumber
        })
        .then( function() {
          // Account created, redirect to home
          $location.path('/');
        })
        .catch( function(err) {
          err = err.data;
          $scope.errors = {};

          // Update validity of form fields that match the mongoose errors
          angular.forEach(err.errors, function(error, field) {
            form[field].$setValidity('mongoose', false);
            $scope.errors[field] = error.message;
          });
        });
      }
    };
  });