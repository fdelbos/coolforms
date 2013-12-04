## 
## email.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validatorEmail', ->
      
    validator = (name, values, rule) ->
      p = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
      if values[name] and values[name].match p then true else false

    return {
      validator: validator
      init: null
    }
  )
