'use strict';

angular.module('xoceanManage')
	.factory 'UserManage', ($resource)->
		return $resource('/api/manage/users/:id', {
				id: "@id"
			}, {
				get: {
					method: 'GET'
				}
				postMail: {
					method: 'POST'
				}
			})