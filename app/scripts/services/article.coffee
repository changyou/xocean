'use strict'

angular.module('xoceanApp')
.service 'Article', ($resource) ->
	$resource '/api/article/:id', {
		id: '@_id'
		}, {
			create: {
				method: 'POST'
			},
			save: {
				method: 'PUT'
			},
			get: {
				method: 'GET'
			},
			getNews: {
				method: 'GET'
				url: '/api/article/getNews'
			},
			getOne: {
				method: 'GET'
				url: '/api/article/:id/show'
			}
		}
