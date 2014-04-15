'use strict'

describe 'Directive: ngCurfocus', () ->

  # load the directive's module
  beforeEach module 'xoceanApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ng-curfocus></ng-curfocus>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the ngCurfocus directive'
