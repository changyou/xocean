'use strict';

angular.module('xoceanApp')
  .controller('MainCtrl', function ($scope,Article,Report) {
  	Article.getNews(function(res){
  		$scope.newsList = res.data;
  	});

  	$scope.repoList = Report.query();
  	Report.workList(function(res){
  		$scope.workList = res.data[0];
  	});
  	$scope.$watch('currentUser.group' ,function(group){
  		switch (group){
  			case 1 :
  				$scope.currentUser.group = "技术-应用一组";
  				break;
  			case 2 :
  				$scope.currentUser.group = "技术-应用二组";
  				break;
  			case 3 :
  				$scope.currentUser.group = "技术-系统组";
  				break;
  			case 4 :
  				$scope.currentUser.group = "技术-前端组";
  				break;
  			case 5 :
  				$scope.currentUser.group = "技术-Android组";
  				break;
  			case 6 :
  				$scope.currentUser.group = "设计-WebUI";
  				break;
  			case 7 :
  				$scope.currentUser.group = "设计-FlashUI";
  				break;
  			default:
  				$scope.currentUser.group = "技术-前端组";
  				break;
  		}
  	})

  });
