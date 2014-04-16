'use strict'

describe 'Directive: mdeditor', () ->

  # load the directive's module
  beforeEach module 'xoceanApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<mdeditor></mdeditor>'
    element = $compile(element) scope
    expect(element.text()).toBe ''
