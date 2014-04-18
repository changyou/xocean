'use strict';

describe('Directive: mdeditor', function() {
  beforeEach(module('xoceanApp'));

  var element;

  it('should make hidden element visible', inject(function($rootScope, $compile) {
    element = angular.element('<mdeditor></mdeditor>');
    element = $compile(element)($rootScope);
    expect(element.text()).toBe('');
  }));
});
