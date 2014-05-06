'use strict'

describe 'Directive: ngBtnList', () ->

  # load the directive's module
  beforeEach module 'xoceanApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    # element = angular.element '<ng-btn-list></ng-btn-list>'
    # element = $compile(element) scope
    # expect(element.text()).toBe 'this is the ngBtnList directive'
