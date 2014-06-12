'use strict';

angular.module('xoceanApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(function ($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'partials/main',
        controller: 'MainCtrl',
        authenticate: true
      })
      .when('/login', {
        templateUrl: 'partials/login',
        controller: 'LoginCtrl'
      })
      .when('/signup', {
        templateUrl: 'partials/signup',
        controller: 'SignupCtrl',
        resolve: { id: function() {} }
      })
      .when('/signup/:id', {
        templateUrl: 'partials/signup',
        controller: 'SignupCtrl',
        resolve: {
          id: function($route) {
            return $route.current.params.id;
          }
        }
      })
      .when('/settings/password', {
        templateUrl: 'partials/settings',
        controller: 'SettingsCtrl',
        authenticate: true
      })
      .when('/settings/info', {
        templateUrl: 'partials/setinfo',
        controller: 'SetInfoCtrl',
        authenticate: true
      })
      .when('/article/list', {
        templateUrl: 'partials/article',
        controller: 'ArticleCtrl',
        authenticate: true,
        resolve: { id: function() {} }
      })
      .when('/report', {
        templateUrl: 'partials/report',
        controller: 'ReportCtrl',
        authenticate: true
      })
      .when('/report/edit', {
        templateUrl: 'partials/reporteditor',
        controller: 'ReporteditorCtrl',
        authenticate: true,
        resolve: { id: function() {} }
      })
      .when('/report/edit/:id', {
        templateUrl: 'partials/reporteditor',
        controller: 'ReporteditorCtrl',
        authenticate: true,
        resolve: {
          id: function($route) {
            return $route.current.params.id;
          }
        }
      })
      .when('/article/:id/show', {
        templateUrl: 'partials/artdetail',
        controller: 'ArticleCtrl',
        authenticate: true,
        resolve: {
          id: function($route) {
            return $route.current.params.id;
          }
        }
      })
      .when('/features', {
        templateUrl: 'partials/features',
        controller: 'FeaturesCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });

    $locationProvider.html5Mode(true);

    // Intercept 401s and redirect you to login
    $httpProvider.interceptors.push(['$q', '$location', function($q, $location) {
      return {
        'responseError': function(response) {
          if(response.status === 401) {
            $location.path('/login');
            return $q.reject(response);
          }
          else {
            return $q.reject(response);
          }
        }
      };
    }]);
  })
  .run(function ($rootScope, $location, Auth) {

    // Redirect to login if route requires auth and you're not logged in
    $rootScope.$on('$routeChangeStart', function (event, next) {
      
      if (next.authenticate && !Auth.isLoggedIn()) {
        $location.path('/login');
      }
    });
  });