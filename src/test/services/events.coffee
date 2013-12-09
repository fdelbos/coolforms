## 
## events.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  5 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'events tests', ->

  beforeEach(module('CoolFormServices'))

  it 'should add an event and fire it', inject((eventService) ->
    event = eventService()
    hasFired = false
    h =
      error: (data) -> hasFired = data
    event.watchField("test", h)
    event.handle("test", "error", true)
    expect(hasFired).toEqual true
  )

  it 'should not crash on undefined events and fields', inject((eventService) ->
    e = eventService()
    e.watchField("test", null)
    e.handle("test", "error")
    e.handle("test", "test")
    e.handle("test", "test", true)
  )
