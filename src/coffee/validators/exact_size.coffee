## 
## exact_size.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('exactSizeValidator', ->

    validator = (name, fields, options) ->
      if !fields[name].value? or typeof fields[name].value != "string"
        return false
      if fields[name].value.length == options.size then true else false

    return {
      validator: validator
      init: null
    }
  )
