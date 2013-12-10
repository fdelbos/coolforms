## 
## registration.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  2 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('registrationService', (
    validationService,
    eventService,
    networkService,
    displayService) ->

    return (form)->
      events = eventService()
      validation = validationService(events)
      values = {}
      display = displayService(events, values)
      
      setFields = (pages) ->
        p = 0
        for page in pages
          for line in page.lines
            line.fields.map (f) -> validation.initValidation(f, services)
          p += 1

      changeValue = (fieldName, value) ->
        values[fieldName] = value
        validation.removeError(fieldName)
        events.handle(fieldName, "change", value)

      registerField = (fieldName, eventHandlers) ->
        events.watchField(fieldName, eventHandlers)
        return (value) ->
          changeValue(fieldName, value)

      submit = ->
        if validation.validateAll(values) is false then return
        params =
          url: form.url,
          method: if form.method? then form.method else "POST"
          success: -> console.log "success"
          error: -> console.log "error"
          headers: if form.headers? then form.headers else {}
        networkService().sendForm(params, values)

      registerDependencies = (deps) ->
        for d in deps
          f = angular.injector([d.module]).get(d.factory)          
          if d.type == "validator" then validation.add(d.name, f)

      services =
        display: display
        registerField: registerField
        validateField: (fieldName) -> validation.validateField(fieldName, values)
        validateFields: (fieldList) -> validation.validateFields(fieldList, values)
        validateAll: -> validation.validateAll(values)
        watchField: events.watchField
        submit: submit
      if form.dependencies? then registerDependencies(form.dependencies)
      setFields(form.pages)
      return services
  )
