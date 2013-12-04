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
      handlers =
        ok: {}
        errors: {}
        change: {}

      initValidation = (field) ->
        if field.validation?
          for rule in field.validation
            if validators[rule.validator]? and validators[rule.validator].init?
              validators[rule.validator].init(field.name, rule, services)
      
      setFields = (pages) ->
        p = 0
        for page in pages
          for line in page.lines
            for field in line.fields
              fields[field.name] = field
              initValidation(fields[field.name])
          p += 1

      handle = (fieldName, h, data) ->
        if !h[fieldName]? then return
        for fn in h[fieldName]
          if data? then fn(data) else fn()

      removeError = (fieldName) ->
        delete errors[fieldName]
        handle(fieldName, handlers.ok)

      validateField = (fieldName) ->
        field = fields[fieldName]
        if field.validation?
          for rule in field.validation
            if validators[rule.validator] and validators[rule.validator].validator?
              if validators[rule.validator].validator(fieldName, values, rule) is false
                errors[fieldName] = rule.options.message
                handle(fieldName, handlers.errors,rule.options.message)
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
        handle(fieldName, handlers.change, value)

      addHandler = (field, fn, list) ->
        if !list[field]? then list[field] = []
        if fn? then list[field].push(fn)

      watchField = (fieldName, onOk, onError, onChange) ->
        if onOk? then addHandler(fieldName, onOk, handlers.ok)
        if onError? then addHandler(fieldName, onError, handlers.errors)
        if onChange? then addHandler(fieldName, onChange, handlers.change)

      registerField = (fieldName, onOk, onError, onChange) ->
        watchField(fieldName, onOk, onError, onChange)
        return (value) ->
          valueChange(fieldName, value)

      registerController = (controllerScope, form) ->
        setFields(form.pages)
      
      services =
        registerController: registerController
        registerField: registerField
        validateField: validateField
        validateFields: validateFields
        validateAllFields: validateAllFields
        watchField: watchField

      return services
  )
