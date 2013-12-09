## 
## display.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  5 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('displayService', ->

    return (events, values) ->

      valueIn = (value, l) ->
        for e in l
          if e == value then return true
        return false

      shouldShow = (conds) ->
        for cond in conds
          if valueIn(values[cond.field], cond.values) then return true
        return false
          
      shouldHide = (conds) -> !shouldShow(conds)

      register = (conds, cb, checker) ->
        for cond in conds
          events.watchField(cond.field, {change: -> cb checker(conds)})

      display =
        showWhen: (conds, cb) -> register(conds, cb, shouldShow)
        hideWhen: (conds, cb) -> register(conds, cb, shouldHide)
      return display
  )
