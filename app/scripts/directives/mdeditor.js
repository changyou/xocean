'use strict';

/**
 * markdown编辑器指令
 * @return {[type]} [description]
 */
angular.module('xoceanApp').directive('mdeditor', function() {
  return {
    restrict: 'A',
    scope:true,
    link: function postLink(scope, element, attrs) {
    	var opt = {
            initialFrameWidth:"100%",
            toolbar:[
	            'source | undo redo | bold italic underline strikethrough | forecolor backcolor   ',
	            'insertorderedlist insertunorderedlist  paragraph | fontfamily fontsize' ,
	            '| justifyleft justifycenter justifyright justifyjustify |',
	            'link unlink image removeformat',
	            '| horizontal preview fullscreen' 
	        ]
        };

        if(window.um) um.destroy();
 		window.um = UM.getEditor(attrs.name, opt);

        scope.$watch("report", function(report){ 
            if(scope.report.html) um.setContent(scope.report.html);
        },true);

        um.addListener('contentChange',function(){
        	scope.report.html = um.getContent();
            scope.report.cleanHtml = um.getContentTxt();
        });

    }
  };
});
