'use strict'

angular.module('xoceanApp')
  .controller 'ReportCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings