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
        field = fields.name
        if field.validation?
          for rule in field.validation
            if rule.validator in validation
              if rule.validator(name, values, rule) is false
                errors[name] = rule.options.message
                return rule.options.message
        delete errors[name]              
        null

      dispatchResult = (name, result) ->
        dest = 'validation_' + name
        ok = if result == null then true else false
        scope.$emit(dest, {'ok': ok, 'msg': result})
  
      scope.$on('register', (event, field) ->
        event.stopPropagation()
        fields[field.name] = field
        values[field.name] = null
      )

      scope.$on('valueChange', (event, data) ->
        event.stopPropagation()
        console.log data
        values[data.name] = data.value
      )

      scope.$on('validateForm', (event) ->
        event.stopPropagation()
        for f in fields.keys
          dispatchResult(f.name, validateField(f.name))
      )
  )
