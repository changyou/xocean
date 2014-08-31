'use strict'

angular.module('xoceanApp')
    .controller 'ArticleCtrl', ($scope, Article,$sce,id)->
        $scope.page = 0;

        if id
            Article.getOne {id: id},(res)->
                repo = res.data
                $scope.article = repo
        else
            Article.get {page: $scope.page},(res)->
                $scope.list = res.data
                for item,index in $scope.list
                    $scope.list[index].content = $sce.trustAsHtml res.data[index].content
