'use strict';

angular.module('xoceanApp')
  .controller('SignupCtrl', function ($scope, Auth, $location, id) {
    if(id){
      $scope.user = {email:id};
    }else{
      $scope.user = {};
    }
    
    $scope.errors = {};
    $scope.show1=true;
    $scope.show2=false;

    $scope.showReceivers = function (value) {
      $scope.showReceiversArray = $scope.stringToArray(value);
      if($scope.showReceiversArray.length){
        $scope.show2=true;
        $scope.show1=false;
      }
    }
    $scope.stringToArray = function(string){
      string = (string+"").replace(/，|;|；/g,",").replace(/\s/g,",").replace(/,+/g,",").replace(/^,|,$/g,"");
      if(!string){
        return [];
      }
      var arr = string.split(",")
      var temp=arr.slice(0);
      for(var i=0;i<temp.length;i++){
        for(var j=i+1;j<temp.length;j++){
          if(temp[j]==temp[i]){
            temp.splice(j,1);
            j--;
          }
        }
      }
      return temp;
    }
    $scope.editReceivers = function(){
      $scope.show1=true;
      $scope.show2=false;
    }

    $scope.register = function(form) {
      $scope.submitted = true;
  
      if(form.$valid) {
        Auth.createUser({
          name: $scope.user.name,
          email: $scope.user.email,
          password: $scope.user.password,
          group: $scope.user.group,
          receivers: $scope.stringToArray($scope.user.receivers)
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