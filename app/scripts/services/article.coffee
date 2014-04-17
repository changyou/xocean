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
			}
		}
