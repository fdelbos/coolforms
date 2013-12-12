## 
## validation.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  4 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('validationService', (validators) ->
    
    return(events) ->
      
      errors = {}
      fields = {}

      removeError = (fieldName) ->
        delete errors[fieldName]
        events.handle(fieldName, "ok")
        true

      setError = (fieldName, msg) ->
        msg = if msg == null then true else msg
        errors[fieldName] = msg
        events.handle(fieldName, "error", msg)
        return false
                  
      initValidation = (field, services) ->
        fields[field.name] = field
        if field.validation? then field.validation.map (rule) ->
          vl = validators.get(rule.validator)
          if vl? and vl.init? then vl.init(field.name, rule, services)

      validateForRule = (fieldName, rule, values) ->
        msg = null
        vl = validators.get(rule.validator)
        if !vl or !vl.validator? then return true
        if vl.validator(fieldName, values, rule) is false
          if rule.options? and rule.options.message? then msg = rule.options.message
          return setError(fieldName, msg)
        return true

      validateField = (fieldName, values) ->
        field = fields[fieldName]
        if field.validation?
          for rule in field.validation
            if !validateForRule(fieldName, rule, values) then return false
        removeError(fieldName)

      validateFields = (fieldList, values) ->
        result = true
        for f in fieldList
          if !validateField(f, values) then result = false
        result

      validateAll = (values) ->
        validateFields(Object.keys(fields), values)

      return {
        removeError: removeError
        initValidation: initValidation
        validateField: validateField
        validateFields: validateFields
        validateAll: validateAll
        add: (validatorName, factory) -> validators.add(validatorName, factory)
      }
  )
