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
        scope.$watch "source",(data)->
            if data&&data.length > 0
                element.find("li").each ()->

                    $(this).attr "draggable","true"

                    $(this).on "dragstart", (e)->
                        $(this).addClass "beDraged"
                        dragTarget = $(e.currentTarget).index();
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
            scope.target.push({ status: "none", content: scope.source[dragTarget].content})
            dragTarget = null;
            $rootScope.$digest()
            return 

        
  )
