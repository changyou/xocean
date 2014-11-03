'use strict'

angular.module('xoceanApp')
  .directive('ngActips', () ->
    scope:true
    restrict: 'A'
    link: (scope, element, attrs) ->
        sendersLength = 0
        launcher = attrs.ngActips 

        if launcher == "currentSenders" 
          sendHandle = scope.addSender
          checkHandle = scope.senders
           
        else
          sendHandle = scope.addCopyer
          checkHandle = scope.copyers
          

        scope.$watch launcher, (senders)->
            if !senders then return
            scope.curindex = 0
            sendersLength = senders.length
            return

        #按键捕获
        scope.chooseSender = (e)->
               if e.keyCode == 13        #enter
                   e.preventDefault()
                   sendHandle scope[launcher][scope.curindex].name
                   if launcher == "currentSenders" then scope.currentSender="" else scope.currentCopyer=""

               else if e.keyCode == 38 #up
                   e.preventDefault()
                   if scope.curindex > 0 then --scope.curindex
                   
               else if e.keyCode == 40 #down
                   e.preventDefault()
                   if scope.curindex < sendersLength-1 then ++scope.curindex
               else if e.keyCode == 8 
               	   if launcher == "currentSenders" then cur = scope.currentSender else cur = scope.currentCopyer
                   if (checkHandle.length > 0 && !cur)
                     checkHandle.pop()
               return

  

  )
