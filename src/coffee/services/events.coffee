## 
## events.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  4 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('eventService',  ->

    return ->
      handlers =
        ok: {}
        error: {}
        change: {}

      handle = (fieldName, type, data) ->
        if !handlers[type]? or !handlers[type][fieldName]? then return
        for fn in handlers[type][fieldName]
          if data? then fn(data) else fn()
    
      watchField = (fieldName, eventHandlers) ->
        for type of eventHandlers
          if handlers[type]?
            if !handlers[type][fieldName]? then handlers[type][fieldName] = []
            handlers[type][fieldName].push(eventHandlers[type])

      event =
        handle: handle
        watchField: watchField
  )
