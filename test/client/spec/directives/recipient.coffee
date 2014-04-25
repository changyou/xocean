'use strict'

describe 'Directive: recipient', () ->

  # load the directive's module
  beforeEach module 'xoceanApp',['components']

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should have data`s model', inject ($compile) ->
    element = angular.element '*[recipient]'
    element = $compile(element) scope
    should.exist(element.attr("ng-recp-data"));
