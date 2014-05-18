'use strict';

angular.module('xoceanManage')
	.factory 'UserManage', ($resource)->
		return $resource('/api/manage/users/:id', {
				id: "@id"
			}, {
				create: {
					method: 'POST'
				}
				get: {
					method: 'GET'
				}
				postMail: {
					method: 'POST'
				}
				changeStatus: {
					method: 'PUT'
					params: {
						id: 'changeStatus'
					}
				}
				addAllUser: {
					method: 'PUT'
					params: {
						id: 'addallnew'
					}
				}
			});
	.service 'userManService', ()->

		userGroup = [
			{
				name: "前端组"
				users: ["chixiaojing", "zhoushufeng", "liujianfeng", "liyi", "xiatian", "jiangzhide", "zhangning", "lixiaolu"]
			}
			{
				name: "测试组"
				users: ["liyi", "xiatian", "jiangzhide"]
			}
			{
				name: "测试组2"
				users: ["zhangning", "lixiaolu"]
			}
		]


		this.getUserGroup = (callback)->
			callback userGroup
			return

		return