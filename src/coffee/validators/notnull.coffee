## 
## notnull.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 15 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('notNullValidator', ->
    validator = (name, fields, options) ->
      v = fields[name].value
      if v is undefined or v is null then return false
      else true

    return {
      validator: validator
      init: null
    } 
  )
