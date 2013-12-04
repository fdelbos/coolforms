## 
## notblank.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validatorNotBlank', ->
    validator = (name, values, rule) ->
      v = values[name]
      if v is undefined or v is null then return false
      if v is true or v is false then return true
      if v and !isNaN(v) then return true
      if (v and (v.replace /^\s+|\s+$/g, "").length > 0) then true
      else false

    return {
      validator: validator
      init: null
    } 
  )
