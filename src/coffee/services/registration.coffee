## 
## registration.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  2 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('registrationService', (validationService, eventService, networkService) ->

    return ()->
      form = null
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

      registerField = (fieldName, eventHandlers) ->
        events.watchField(fieldName, eventHandlers)
        return (value) ->
          valueChange(fieldName, value)

      registerController = (controllerScope, formObj) ->
        form = formObj
        setFields(form.pages)

      submit = ->
        if validation.validateAll(values) is false then return
        params =
          url: form.url,
          method: if form.method? then form.method else "POST"
          success: -> console.log "success"
          error: -> console.log "error"
          headers: if form.headers? then form.headers else {}
        networkService().sendForm(params, values)

      services =
        registerController: registerController
        registerField: registerField
        validateField: (fieldName) -> validation.validateField(fieldName, values)
        validateFields: (fieldList) -> validation.validateFields(fieldList, values)
        validateAll: -> validation.validateAll(values)
        watchField: events.watchField
        submit: submit

      return services
  )
