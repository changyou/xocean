'use strict'

describe 'Service: Report', () ->

  # load the service's module
  beforeEach module 'xoceanApp'

  # instantiate service
  Report = {}
  beforeEach inject (_Report_) ->
    Report = _Report_

  it 'should do something', () ->
    expect(!!Report).toBe true
