'use strict';

angular.module('xoceanApp')
  .factory('Session', function ($resource) {
    return $resource('/api/session/');
  });
