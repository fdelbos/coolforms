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
      _handlers =
        ok: {}
        errors: {}
        change: {}

      handle = (fieldName, type, data) ->
        if !_handlers[type]? or !_handlers[type][fieldName]? then return
        for fn in _handlers[type][fieldName]
          if data? then fn(data) else fn()
    
      watchField = (fieldName, eventHandlers) ->
        for type of eventHandlers
          if _handlers[type]?
            if _handlers[type][fieldName]? then _handlers[type][fieldName] = []
            _handlers[type][fieldName].push(eventHandlers[type])

      event =
        handle: handle
        watchField: watchField
  )
