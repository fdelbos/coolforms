## 
## sameas.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validatorSameAs', ->

    validator = (name, values, rule) ->
      if values[name] == values[rule.options.field] then true else false

    init = (name, rule, services) ->
      services.watchField(rule.options.field, null, null, (value) ->
        services.validateField(name)
      )

    return {
      validator: validator
      init: init
    }       
  )
