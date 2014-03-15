angular.module('xoceanApp')
	.controller 'ReporteditorCtrl', ($scope, Report, id) ->

		$scope.report = if not id then {} else Report.get { id: id }

		$scope.save = ->
			if not $scope.report._id
				$scope.report = new Report $scope.report
				$scope.report.$create()
			else
				$scope.report.$save()


