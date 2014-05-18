'use strict'

angular.module('xoceanApp')
.service 'Report', ($resource) ->
	$resource '/api/report/:id', {
		id: '@_id'
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
			workList: {
				method: 'GET'
				url: '/api/report/lastest'
			}
		}

