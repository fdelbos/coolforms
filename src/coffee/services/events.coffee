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
        errors: {}
        change: {}

      selectHandler = (handler) ->
        if handler == "ok" then return handlers.ok
        if handler == "errors" then return handlers.errors
        if handler == "change" then return handlers.change

      handle = (fieldName, handler, data) ->
        h = selectHandler(handler)
        if !h[fieldName]? then return
        for fn in h[fieldName]
          if data? then fn(data) else fn()

      addHandler = (field, fn, list) ->
        if !list[field]? then list[field] = []
        if fn? then list[field].push(fn)

    
      watchField = (fieldName, onOk, onError, onChange) ->
        if onOk? then addHandler(fieldName, onOk, handlers.ok)
        if onError? then addHandler(fieldName, onError, handlers.errors)
        if onChange? then addHandler(fieldName, onChange, handlers.change)

      event =
        handle: handle
        watchField: watchField
  )
