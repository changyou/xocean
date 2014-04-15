'use strict'

angular.module('xoceanApp')
  .directive('ngCurfocus', () ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      if scope.$eval(attrs.ngCurfocus) then element.focus()
      return
  )
