'use strict'

angular.module('xoceanApp')
	.controller 'ReportCtrl', ($scope, Report)->
		$scope.list = Report.query()

		$scope.remove = (id)->
			Report.remove { id: id }
			$scope.list = Report.query()
