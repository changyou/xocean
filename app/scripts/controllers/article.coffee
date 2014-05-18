'use strict'

angular.module('xoceanApp')
    .controller 'ArticleCtrl', ($scope, Article)->
        Article.get (res)->
            $scope.list = res.data
