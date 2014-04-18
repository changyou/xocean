'use strict';

angular.module('xoceanManage')
	.factory 'UserManage', ($resource)->
		return $resource('/api/manage/users/:id', {
				id: "@id"
			}, {
				create: {
					method: 'POST'
				}
				save: {
					method: 'PUT'
				}
				get: {
					method: 'GET'
				}
				postMail: {
					method: 'POST'
				}
			})