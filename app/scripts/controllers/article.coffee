'use strict'

angular.module('xoceanApp')
    .controller 'ArticleCtrl', ($scope, Article,$sce,id)->
        if id
            Article.getOne {id: id},(res)->
                repo = res.data
                $scope.article = repo
        else
            Article.get (res)->
                $scope.list = res.data
                for item,index in $scope.list
                    $scope.list[index].content = $sce.trustAsHtml res.data[index].content
