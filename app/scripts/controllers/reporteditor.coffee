angular.module('xoceanApp')
	.controller 'ReporteditorCtrl', ($scope, $location, Report, id) ->

		$scope.report = if not id then {} else Report.get { id: id }

		$scope.save = ->
			if not $scope.report._id
				$scope.report = new Report $scope.report
				$scope.report.$create()
			else
				$scope.report.$save()


		$scope.send = ->
			if confirm('确定发送？')
				$scope.report.$postMail()
					.success ->
						$location.url("/report")
