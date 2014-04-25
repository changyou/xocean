'use strict'

angular.module('xoceanManage')
	.controller 'ManageUserCtrl', ($scope, $location, UserManage, userManService)->
		$scope.list = UserManage.query()
		$scope.updateUser = []
		$scope.volumeUser = ""
		$scope.emailSuffix = "@cyou-inc.com"

		$scope.send = (id)->
			UserManage.postMail {id: id}, (result)->
				if result.msg is "error"
					alert "发送邮件失败"
			alert "发送邮件完成"

		$scope.addAllUser = (e)->
			if(e && e.keyCode is 13) or (e.type is 'click')
				if $scope.volumeUser is ""
					$scope.isAdd = false
					return
				UserManage.addAllUser {nameList: $scope.volumeUser, emailSuffix: $scope.emailSuffix}, (result)->
					if result.msg is "success"
						$location.url("/index")

		$scope.addGroupUser = (userStr)->
			$scope.volumeUser += userStr + ","

		userManService.getUserGroup (data)->
			$scope.userGroup = data

		return
