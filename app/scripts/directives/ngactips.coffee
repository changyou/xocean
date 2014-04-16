'use strict'

angular.module('xoceanApp')
  .directive('ngActips', () ->
    scope:true
    restrict: 'A'
    link: (scope, element, attrs) ->
    	sendersLength = 0
    	launcher = attrs.ngActips 
    	if launcher == "currentSenders" then sendHandle=scope.addSender else sendHandle=scope.addCopyer
    	 
    	scope.$watch launcher, (senders)->
    		scope.curindex = 0
    		sendersLength = senders.length
    		return

    	#按键捕获
    	scope.chooseSender = (e)->
   			if e.keyCode == 13		#enter
   				e.preventDefault()
   				sendHandle scope[launcher][scope.curindex].name
   			else if e.keyCode == 38 #up
   				e.preventDefault()
   				if scope.curindex > 0 then --scope.curindex
   				
   			else if e.keyCode == 40 #down
   				e.preventDefault()
   				if scope.curindex < sendersLength-1 then ++scope.curindex
   			 
   			return

  

  )
