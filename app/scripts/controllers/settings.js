'use strict';

angular.module('xoceanApp')
  .controller('SettingsCtrl', function ($scope, User, Auth) {
    $scope.errors = {};

    $scope.changePassword = function(form) {
      $scope.submitted = true;

      if(form.$valid) {
        Auth.changePassword( $scope.user.oldPassword, $scope.user.newPassword )
        .then( function() {
          $scope.message = 'Password successfully changed.';
        })
        .catch( function() {
          form.password.$setValidity('mongoose', false);
          $scope.errors.other = 'Incorrect password';
        });
      }
		};
  }).controller('SetInfoCtrl', function ($scope, User, Auth) {
    $scope.errors = {};
    $scope.user = Auth.currentUser();

    $scope.changeInfo = function(form) {
      $scope.submitted = true;
      if(form.$valid) {
        Auth.changeInfo({
          group: $scope.user.group,
          receivers: ($scope.user.receivers),
          jobNumber: $scope.user.jobNumber
        })
        .then( function() {
          $scope.message = '修改成功';
        })
        .catch( function() {
        });
      }
    };
  });
