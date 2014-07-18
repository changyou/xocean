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

		$scope.resetStatus = (id)->
			UserManage.changeStatus {userId: id}, (result)->
				if result.msg is "error"
					alert "修改用户状态失败"
				if result.msg is "success"
					$scope.list = UserManage.query()

		$scope.addAllUser = (e)->
			if(e && e.keyCode is 13) or (e.type is 'click')
				userlist = $scope.multipleUser.toString().split ";"
				regStr = /^ ?([\u4e00-\u9fa5].*) <(.*)>$/
				personObj = []

				for person,ind in userlist
					name = person.replace regStr,(word,name,email)->
						personObj.push {
							name : name
							email : email
						}
						return

				UserManage.addAllUser {userlist:personObj}, (result)->
					if result.msg is "success"
						$scope.list = UserManage.query()
						$scope.multipleUser = null

		$scope.addGroupUser = (userStr)->
			$scope.volumeUser += userStr + ","

		userManService.getUserGroup (data)->
			$scope.userGroup = data

		return
