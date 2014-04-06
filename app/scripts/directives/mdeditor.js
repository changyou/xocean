'use strict';

/**
 * markdown编辑器指令
 * @return {[type]} [description]
 */
angular.module('xoceanApp').directive('mdeditor', function() {
  return {
    restrict: 'A',
    scope:{
    	ngHTML : "="
    },
    link: function postLink(scope, element, attrs) {
    	console.log(scope)
    	var opt = {
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
 		if(scope.report.html) um.setContent(scope.html);
        um.addListener('contentChange',function(){
        	scope.report.html = um.getContent();
        });

    }
  };
});
