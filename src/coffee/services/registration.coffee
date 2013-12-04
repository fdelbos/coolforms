## 
## registration.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  2 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('registrationService', (validationService, eventService) ->

    return ()->      
      events = eventService()
      validation = validationService(events)
      values = {}
      
      setFields = (pages) ->
        p = 0
        for page in pages
          for line in page.lines
            for field in line.fields
              validation.initValidation(field, services)
          p += 1


      valueChange = (fieldName, value) ->
        values[fieldName] = value
        validation.removeError(fieldName)
        events.handle(fieldName, "change", value)

      registerField = (fieldName, onOk, onError, onChange) ->
        events.watchField(fieldName, onOk, onError, onChange)
        return (value) ->
          valueChange(fieldName, value)

      registerController = (controllerScope, form) ->
        setFields(form.pages)
      
      services =
        registerController: registerController
        registerField: registerField
        validateField: (fieldName) -> validation.validateField(fieldName, values)
        validateFields: (fieldList) -> validation.validateFields(fieldList, values)
        validateAll: -> validation.validateAll(values)
        watchField: events.watchField

      return services
  )
