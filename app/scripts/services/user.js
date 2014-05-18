'use strict';

angular.module('xoceanApp')
	.factory('User', function ($resource) {
		return $resource('/api/users/:id', {
			id: '@id'
		}, { //parameters default
			update: {
				method: 'PUT',
				params: {}
			},
			get: {
				method: 'GET',
				params: {
					id:'me'
				}
			},
			activate:{
				method: 'POST',
				url:"/api/users/activate"
			},
			findByCode:{
				method: 'GET',
				url:"/api/user/findByCode"
			},
      changeInfo:{
        method: 'POST',
        url:"api/user/changeInfo"
      }
		});
	});
