'use strict'

angular.module('xoceanManage')
	.controller 'ManageUserCtrl', ($scope, UserManage)->
		$scope.list = UserManage.query()
		# console.log UserManage.query()
		return

