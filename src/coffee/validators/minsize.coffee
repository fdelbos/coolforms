## 
## minsize.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validatorMinSize', ->

    validator = (name, values, rule) ->
      if values[name].length >= rule.options.size then true else false

    return {
      validator: validator
      init: null
    }
  )
