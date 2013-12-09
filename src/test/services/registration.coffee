## 
## registration.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  9 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'registration tests', ->

  beforeEach(module('CoolFormServices'))

  form =
    name: "form"
    action: "/"
    dependencies: [
      type: 'validator'
      module: 'TestModule'
      factory: 'testFactory'
      name: 'testValidator'
      ]
    pages: [
      lines:[
        fields:[
          {
            name: "field1"
            type: "text",
            label: "field 1"
            validation: [
              validator:"email"
              options: [
                message: "not an email"
                ]
              ]
            },
          {
            name: "field2",
            type: "text",
            label: "field 2",
            validation: [
              validator:"testValidator",
              options: [
                message: "test validation failed"
                ]
              ]
            }
          ]
        ]
      ]

  
  testFactoryInit = false
  angular.module('TestModule', []).factory('testFactory', ->
    validator = (name, values, rule) ->
      if values[name]? and values[name] == 'test' then return true
      return false
    return {
      validator: validator
      init: (name, rule, services) ->
        testFactoryInit = true
    }
  )

  formSend = false
  angular.module('CoolFormServices').factory('networkService', ->
    return ->
      sendForm = (params, data) ->
        formSend = true
      return {
        sendForm: sendForm
      }
    )

  it 'should deal wtih a value', inject((registrationService) ->
        
    service = registrationService(form)
    changeValue = service.registerField('field1', null)
    fieldValue = false
    fieldError = false
    handlers =
      change: (value) -> fieldValue = value
      error: (msg) -> fieldError = true
      ok: () -> fieldError = false


    
    expect(testFactoryInit).toEqual true

    # normal validation    
    service.watchField('field1', handlers)
    
    expect(fieldValue).toEqual false
    changeValue(true)
    expect(fieldValue).toEqual true
    changeValue(42)
    expect(fieldValue).toEqual 42


    expect(fieldError).toEqual false
    service.validateField('field1')
    expect(fieldError).toEqual true
    changeValue('fred@mail.com')
    expect(fieldError).toEqual false
    service.validateField('field1')
    expect(fieldError).toEqual false

    changeValue('wrong')
    expect(fieldError).toEqual false
    service.validateAll()
    expect(fieldError).toEqual true
    changeValue('fred@mail.com')
    

    # dependencie validation
    changeValue = service.registerField('field2', null)
    expect(service.validateField('field2')).toEqual false
    changeValue('test')
    expect(service.validateField('field2')).toEqual true
    changeValue(false)
        
    # submit
    expect(formSend).toEqual false
    service.submit()
    expect(formSend).toEqual false
    changeValue('test')
    service.submit()
    expect(formSend).toEqual true


  )
