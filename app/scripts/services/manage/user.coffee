'use strict';

angular.module('xoceanManage')
	.factory 'UserManage', ($resource)->
		return $resource('/api/users/:id', {
				id: "@id"
			}, {
				get: {
					method: 'GET',
					params: {
						id:'me'
					}
				}
			})
