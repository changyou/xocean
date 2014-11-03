'use strict'

angular.module('xoceanApp')
  .directive('ngDragable', ($rootScope) ->
    restrict: 'AE'
    scope: {
        'source':'=ngDragsource'
        'sourceDOM': '@ngDragsourcedom'
        'target':'=ngDragtarget'
        'targetDOM': '@ngDragtargetdom'
        'index':'@sourceindex'
    }
    link: (scope, element, attrs) ->
        dragTarget = null
        scope.$watchCollection "source",(data)->
            if data&&data.length > 0
                element.find("li").each ()->

                    $(this).attr "draggable","true"
                    $(this).on "drag", (e)->
                      dragTarget = $(e.currentTarget).index()
                      localStorage.setItem 'dragTarget', dragTarget
                      return

                    $(this).on "dragstart", (e)->
                        $(this).addClass "beDraged"
                      return

                    $(this).on "dragend", (e)->
                        e.preventDefault()
                        $(this).removeClass "beDraged"
                        $("."+scope.targetDOM).removeClass 'ondrag'
                        return
        

        $("body").delegate "."+scope.targetDOM, "dragenter",(e)->
            e.preventDefault()
            $(this).addClass 'ondrag'
            return

        $("body").delegate "."+scope.targetDOM, "dragover",(e)->
            e.preventDefault();

        $("body").delegate "."+scope.targetDOM, "drop",(e)->
            e.preventDefault()
            $("."+scope.targetDOM).removeClass 'ondrag'
            dragTarget = localStorage.getItem('dragTarget') || 0
            if scope.target and !scope.target[0].content
              scope.target[0]={ status: "none", content: scope.source[dragTarget].content}
            else
              scope.target.push({ status: "none", content: scope.source[dragTarget].content})
            localStorage.removeItem 'dragTarget'
            $rootScope.$digest()
            return 

        
  )
