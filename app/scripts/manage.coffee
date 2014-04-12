'use strict'

angular.module('xoceanManage', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])

.config ($routeProvider, $locationProvider, $httpProvider)->
	$routeProvider
	.when '/',
		templateUrl: 'manage/user'
		controller: 'ManageUserCtrl'
	.otherwise
		redirectTo: '/'