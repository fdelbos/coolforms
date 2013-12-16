## 
## sameas.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('sameAsValidator', ->

    validator = (name, fields, options) ->
      if fields[name].value == fields[options.field].value then true else false

    init = (name, fields, options) ->
      if fields[options.field]?
        fields[options.field].onChange
      services.watchField(rule.options.field, null, null, (value) ->
        services.validateField(name)
      )

    return {
      validator: validator
      init: init
    }       
  )
