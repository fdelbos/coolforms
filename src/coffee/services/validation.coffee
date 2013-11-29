## 
## validation.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('validatorService', (validators) ->
    return (scope) ->

      fields = {}
      values = {}
      errors = {}
  
      validateField = (name) ->
        field = fields[name]
        if field.validation?
          for rule in field.validation
            if validators[rule.validator]?
              if validators[rule.validator](name, values, rule) is false
                errors[name] = rule.options.message
                dispatchResult(name, errors[name])
                return rule.options.message
        delete errors[name]
        dispatchResult(name)
        null

      validateAll = ->
        for f of fields
          dispatchResult(f, validateField(f))
        if errors.length != 0 then false else true

      dispatchResult = (name, result) ->
        dest = 'validation_' + name
        ok = if result == null then true else false
        scope.$broadcast(dest, {'ok': ok, 'msg': result})
  
      scope.$on('register', (event, field) ->
        event.stopPropagation()
        fields[field.name] = field
        values[field.name] = null
      )

      scope.$on('valueChange', (event, data) ->
        event.stopPropagation()
        values[data.name] = data.value
        delete errors[data.name]
        dispatchResult(data.name, null)
      )

      scope.$on('submit', (event) ->
        event.stopPropagation()
        validateAll()
      )

      scope.$on('reset', (event) ->
      )

      
  )
