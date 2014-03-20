'use strict'

describe 'Controller: ReportCtrl', () ->

  # load the controller's module
  beforeEach module 'xoceanApp'

  ReportCtrl = {}
  scope = {}
  $httpBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope) ->

  it 'should attach a list of awesomeThings to the scope', () ->
    
