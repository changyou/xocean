'use strict'

angular.module('xoceanApp')
    .controller 'ArticleCtrl', ($scope, Article,$sce)->
        Article.get (res)->
            $scope.list = res.data
            for item,index in $scope.list
            	$scope.list[index].content = $sce.trustAsHtml res.data[index].content
