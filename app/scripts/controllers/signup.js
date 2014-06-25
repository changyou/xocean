'use strict';

angular.module('xoceanApp')
  .controller('SignupCtrl', function ($scope, Auth, $location, id, $timeout) {
    if(id){
      $scope.user = Auth.preActivateUser({"code":id});
    }else{
      $scope.user = {};
    }

    $scope.errors = {};
    $scope.step = 1;
    $scope.nextStep = function(form){
      if(form.$valid){
        $scope.step ++;
      }else{
        $scope.firstSubmitted = true;
      }
    }
    $scope.preStep = function(){
      $scope.step --;
    }
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
    $scope.checkPassword = function(form) {
        form.rePassword.$error.dontMatch = $scope.user.password !== $scope.user.rePassword;
        if($scope.user.password !== $scope.user.rePassword){
          form.$setValidity("dontMatch",false)
        }else{
          form.$setValidity("dontMatch",true)
        }
    }
  });