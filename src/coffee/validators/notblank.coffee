## 
## notblank.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('notBlankValidator', ->
    validator = (name, fields, options) ->
      v = fields[name].value
      if v is undefined or v is null then return false
      if typeof v == "boolean" and v is true or v is false then return true
      if typeof v == "number" then return true
      if typeof v == "string"
        if (v.replace /^\s+|\s+$/g, "").length > 0 then return true else false
      else false

    return {
      validator: validator
      init: null
    } 
  )
