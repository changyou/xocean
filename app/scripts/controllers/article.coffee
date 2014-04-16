'use strict'

angular.module('xoceanApp')
	.controller 'ArticleCtrl', ($scope, Article)->
		$scope.list = Article.query()
