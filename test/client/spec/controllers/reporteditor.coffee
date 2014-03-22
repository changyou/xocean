'use strict'

describe 'Controller: ReporteditorCtrl', () ->

  # load the controller's module
  beforeEach module 'xoceanApp'

  ReporteditorCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope) ->

  it 'should attach a list of awesomeThings to the scope', () ->
