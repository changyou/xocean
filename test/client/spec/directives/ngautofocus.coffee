'use strict'

describe 'Directive: ngAutofocus', () ->

  # load the directive's module
  beforeEach module 'xoceanApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ng-autofocus></ng-autofocus>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the ngAutofocus directive'
