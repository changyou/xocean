'use strict';

angular.module('xoceanApp').directive('mdeditor', function() {
  return {
    restrict: 'A',
    link: function postLink(scope, element, attrs) {

    	var opt = {
    		basePath:"/styles/editorTheme",
    		container : attrs.id,
    		clientSideStorage: true,
			localStorageName: 'epiceditor',
			useNativeFullscreen: true,
			parser:markdown.toHTML,
			autogrow:{
				minHeight:400,
				maxHeight:580
			},
			button: {
			    preview: true,
			    fullscreen: true,
			    bar: true
			},
			theme: {
			    base: '/base/epiceditor.css',
			    preview: '/preview/stackedit.css',
			    editor: '/editor/epic-light.css'
			},
			string: {
			   togglePreview: '预览模式',
			   toggleFullscreen: '禅模式'
			}
    	};

    	var ed = new EpicEditor(opt).load();
    }
  };
});
