'use strict'

angular.module('xoceanManage')
	.controller 'ManageUserCtrl', ($scope, UserManage)->
		$scope.list = UserManage.query()
		# console.log UserManage.query()

		$scope.send = (id)->
			result = UserManage.postMail({id: id})
			console.log result, result.success
				# .success ->
				# 	console.log("result")

		return

