## 
## email.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('emailValidator', ->
      
    validator = (name, fields, options) ->
      if !fields[name].value? or typeof fields[name].value != "string"
        return false
      p = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
      if fields[name].value.match p then true else false

    return {
      validator: validator
      init: null
    }
  )
