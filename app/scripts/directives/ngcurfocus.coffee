'use strict'

angular.module('xoceanApp')
  .directive('ngCurfocus', () ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      
      #if scope.$last && !scope.$first then element.focus()
      return
  )
