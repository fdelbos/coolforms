## 
## maxsize.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('maxSizeValidator', ->

    validator = (name, values, rule) ->
      if !values[name]? or typeof values[name] != "string" then return false
      if values[name].length <= rule.options.size then true else false

    return {
      validator: validator
      init: null
    }
  )
