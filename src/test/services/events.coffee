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
    dump eventService()
    expect(1).toEqual 1
  )
