'use strict'

describe 'Controller: FeaturesCtrl', () ->

  # load the controller's module
  beforeEach module 'xoceanApp'

  FeaturesCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FeaturesCtrl = $controller 'FeaturesCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
