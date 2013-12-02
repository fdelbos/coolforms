## 
## registration.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  2 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('registrationService', (validators) ->

    return ()->
      
      fields = {}
      errors ={}
      values = {}
      errorHandlers = {}
      okHandlers = {}
      # dependancies = {}

      # setDependancies = (field) ->
      #   if field.dependancies?
      #     for dep in field.dependancies
      #       if !dependancies[dep]? then dependancies[dep] = []
      #       dependancies[dep].push(field.name)

      setFields = (pages) ->
        p = 0
        for page in pages
          for line in page.lines
            for field in line.fields
              fields[field.name] = field
              # setDependancies(field)
          p += 1

      sendError = (fieldName, error) ->
        if !errorHandlers[fieldName]? then return
        for handler in errorHandlers[fieldName]
          handler(error)
    
      sendOk = (fieldName) ->
        if !okHandlers[fieldName]? then return
        for handler in okHandlers[fieldName]
          handler()

      removeError = (fieldName) ->
        delete errors[fieldName]
        # if dependancies[fieldName]?
        #   for dep in dependancies[fieldName]
        #     removeError(dep)
        sendOk(fieldName)

      validateField = (fieldName) ->
        field = fields[fieldName]
        if field.validation?
          for rule in field.validation
            if validators[rule.validator]?
              if validators[rule.validator](fieldName, values, rule) is false
                errors[fieldName] = rule.options.message
                sendError(fieldName, rule.options.message)
                return false
        removeError(fieldName)
        return true

      validateFields = (fieldList) ->
        result = true
        for field in fieldList
          if validateField(field) is false then result = false
        result

      validateAllFields = -> validateFields(Object.keys(fields))

      valueChange = (fieldName, value) ->
        values[fieldName] = value
        removeError(fieldName)

      addHandler = (field, fn, list) ->
        if !list[field]? then list[field] = []
        if fn? then list[field].push(fn)

      registerController = (controllerScope, form) ->
        setFields(form.pages)

      watchFieldValidation = (fieldName, onOk, onError) ->
        if onOk? then addHandler(fieldName, onOk, okHandlers)
        if onError? then addHandler(fieldName, onError, errorHandlers)

      registerField = (fieldName, onOk, onError) ->
        watchFieldValidation(fieldName, onOk, onError)
        return (value) ->
          valueChange(fieldName, value)
      
      services =
        registerController: registerController
        registerField: registerField
        validateField: validateField
        validateFields: validateFields
        validateAllFields: validateAllFields
        watchFieldValidation: watchFieldValidation

      return services
  )
