'use strict'

angular.module('xoceanApp')
  .directive('ngArttab', () ->
    restrict: 'AE'
    link: (scope, element, attrs) ->
      scope.curIndex = -1
      scope.triggerArt = (lock,e)->
        # scope.showContent = lock
  )
