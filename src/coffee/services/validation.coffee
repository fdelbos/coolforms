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
      
      errors ={}
      fields = {}

      removeError = (fieldName) ->
        delete errors[fieldName]
        events.handle(fieldName, "ok")
        true

      setError = (fieldName, msg) ->
        errors[fieldName] = msg
        events.handle(fieldName, "error", msg)
        false
                  
      initValidation = (field, services) ->
        fields[field.name] = field
        if field.validation? then field.validation.map (rule) ->
          vl = validators.get(rule.validator)
          if vl? and vl.init? then vl.init(field.name, rule, services)

      validateField = (fieldName, values) ->
        field = fields[fieldName]
        if field.validation?
          for rule in field.validation
            vl = validators.get(rule.validator)
            if vl and vl.validator?
              if !vl.validator(fieldName, values, rule)
                return setError(fieldName, rule.options.message)
        return removeError(fieldName)

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
      }
  )
