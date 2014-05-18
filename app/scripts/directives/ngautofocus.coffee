'use strict'

angular.module('xoceanApp')
  .directive('ngAutofocus', () ->
    restrict: 'AE'
    scope: { 
      "af":"=ngAutofocus"
    }
    link: (scope, element, attrs) ->
     
      setTimeout ()->
        if scope.af == true then element.focus()
      ,50
      return
  )
