'use strict'

describe 'Service: Datecal', () ->

  # load the service's module
  beforeEach module 'xoceanApp'

  # instantiate service
  Datecal = {}
  beforeEach inject (_Datecal_) ->
    Datecal = _Datecal_

  it 'should do something', () ->
    expect(!!Datecal).toBe true
