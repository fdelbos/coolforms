## 
## display.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  9 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'display tests', ->

  beforeEach(module('CoolFormServices'))
    
  it 'test show when', inject((eventService, displayService) ->
    values =
      field1: "no"
    events = eventService()
    condition =
      field: "field1"
      values: ["yes", true, 1]
    display = displayService(events, values)
    shouldShow = false

    display.showWhen([condition], (val) ->
      shouldShow = val)

    expect(shouldShow).toEqual false

    values["field1"] = "yes"
    events.handle("field1", "change", "yes")
    expect(shouldShow).toEqual true
    
    values["field1"] = "no"
    events.handle("field1", "change", "no")
    expect(shouldShow).toEqual false

    values["field1"] = true
    events.handle("field1", "change", true)
    expect(shouldShow).toEqual true
    
    values["field1"] = false
    events.handle("field1", "change", false)
    expect(shouldShow).toEqual false
    
    values["field1"] = 1
    events.handle("field1", "change", 1)
    expect(shouldShow).toEqual true
    
    values["field1"] = 0
    events.handle("field1", "change", 0)
    expect(shouldShow).toEqual false
  )

  it 'test hide when', inject((eventService, displayService) ->
    values =
      field1: "no"
    events = eventService()
    condition =
      field: "field1"
      values: ["yes", true, 1]
    display = displayService(events, values)

    shouldShow = true

    display.hideWhen([condition], (val) ->
      shouldShow = val)

    expect(shouldShow).toEqual true

    values["field1"] = "yes"
    events.handle("field1", "change", "yes")
    expect(shouldShow).toEqual false
    
    values["field1"] = "no"
    events.handle("field1", "change", "no")
    expect(shouldShow).toEqual true

    values["field1"] = true
    events.handle("field1", "change", true)
    expect(shouldShow).toEqual false
    
    values["field1"] = false
    events.handle("field1", "change", false)
    expect(shouldShow).toEqual true
    
    values["field1"] = 1
    events.handle("field1", "change", 1)
    expect(shouldShow).toEqual false
    
    values["field1"] = 0
    events.handle("field1", "change", 0)
    expect(shouldShow).toEqual true
  )
