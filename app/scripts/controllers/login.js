'use strict';

angular.module('xoceanApp')
  .controller('LoginCtrl', function ($scope, Auth, User, $location, $rootScope) {

    $scope.user = {
      email: '',
      password: ''
    };

    if($rootScope.currentUser !== null){
      $location.url('/');
      return;
    }

    $scope.errors = {};

    $scope.login = function(form) {
      $scope.errors.other = '';
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

    $scope.forgetPwd = function() {
      if($scope.user.email == '') {
        $scope.errors.other = "请填写您的邮箱";
      } else {
        Auth.isUserEmail({
          email: $scope.user.email
        }, function(msg){
          if(msg == false){
            $scope.errors.other = "没有这个用户";
          }else if(msg = true){
            User.sendNewPwd({email:$scope.user.email});
            $scope.errors.other = "管理员已将新密码发送至您的邮箱，请注意查收";
          } else {
            $scope.errors.other = "服务器错误，请联系管理员";
          }
        });
      }
    }
  });