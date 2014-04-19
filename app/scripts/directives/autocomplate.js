'use strict';

angular.module('components')

  /**
   * 自动提示指令
   */
  .directive('typeahead', function () {
    return {
      restrict: 'A',
      require: 'ngModel',
      init: function(scope, element, attrs, ngModel) {
        console.log(element);
      }
    };
  });