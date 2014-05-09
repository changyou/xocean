'use strict';

angular.module('xoceanApp')
  .controller('NavbarCtrl', function ($scope, $location, Auth) {
    $scope.menu = [
      {
        'title': '首页',
        'link': '/'
      },
      {
        'title': '论坛',
        'link': 'http://bb.ijser.cn'
      },
      {
        'title': '技术分享',
        'link': '/article/list'
      },
      {
        'title': '周报',
        'submenu': [
          {
            'title': '周报列表',
            'link': '/report'
          },
          {
            'title': '撰写周报',
            'link': '/report/edit'
          }
        ]
      }
    ];

    $scope.logout = function() {
      Auth.logout()
      .then(function() {
        $location.path('/login');
      });
    };

    $scope.isActive = function(route) {
      return route === $location.path();
    };
  });
