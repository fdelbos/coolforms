## 
## value.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('valueService', ->
    return (scope, field, defaultValue, onOk, onError) ->

      reset = -> 
        scope.value = if field.value? then field.value else defaultValue
      
      scope.$watch('value', (v, o) ->
        scope.$emit('valueChange', {name: field.name, value: scope.value})
      )
      
      scope.$on('validation_' + field.name, (event, error) ->
        scope.error = error
        if error.ok == true and onOk? then onOk()
        if error.ok == false and onError? then onError()
      )
      reset()
      scope.$emit('register', field)
  )
