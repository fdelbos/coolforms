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
      
      initValidation = (field, services) ->
        fields[field.name] = field
        if field.validation?
          for rule in field.validation
            if validators[rule.validator]? and validators[rule.validator].init?
              validators[rule.validator].init(field.name, rule, services)

      validateField = (fieldName, values) ->
        field = fields[fieldName]
        if field.validation?
          for rule in field.validation
            if validators[rule.validator] and validators[rule.validator].validator?
              if validators[rule.validator].validator(fieldName, values, rule) is false
                errors[fieldName] = rule.options.message
                events.handle(fieldName, "errors",rule.options.message)
                return false
        removeError(fieldName)
        return true

      validateFields = (fieldList, values) ->
        result = true
        for field in fieldList
          if validateField(field, values) is false then result = false
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
