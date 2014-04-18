'use strict'

angular.module('xoceanManage')
	.controller 'ManageUserCtrl', ($scope, $http, UserManage)->
		$scope.list = UserManage.query()
		$scope.updateUser = [];

		$scope.send = (id)->
			UserManage.postMail {id: id}, (result)->
				if result.success is true
					alert "发送邮件成功"


		$scope.addUserTem = ()->
			#$scope.updateUser.push($scope.newUser);
			# $scope.user = $scope.newUser
			console.log $scope.newUser
			UserManage.create $scope.newUser, (result)->
				console.log 124

			$scope.newUser = null
				# else
		# 		$scope.report.$save()


		return
