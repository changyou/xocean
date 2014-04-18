'use strict'

angular.module('xoceanManage')
	.controller 'ManageUserCtrl', ($scope, $http, UserManage)->
		$scope.list = UserManage.query()

		$scope.send = (id)->
			UserManage.postMail {id: id}, (result)->
				if result.success is true
					alert "发送邮件成功"


		$scope.addUserTem = (event)->
			console.log event.code


		return
