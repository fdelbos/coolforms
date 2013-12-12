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
              options:
                message: "not an email"
              ]
            },
          {
            name: "field2",
            type: "text",
            label: "field 2",
            validation: [
              validator:"testValidator"
              ]
            }
          ]
        ]
      ]
  
  testFactoryInit = false
  testGetServices = false
  angular.module('TestModule', []).factory('testFactory', ->
    validator = (name, values, rule) ->
      if values[name]? and values[name] == 'test' then return true
      return false
    return {
      validator: validator
      init: (name, rule, services) ->
        testFactoryInit = true
        if services.watchField? then testGetServices = true
        else dump services
    }
  )

  it 'should test validation', inject((registrationService) ->
        
    service = registrationService(form)
    changeEmail = service.registerField('field1', null)
    fieldValue = false
    fieldError = false
    handlers =
      change: (value) -> fieldValue = value
      error: (msg) -> fieldError = true
      ok: () -> fieldError = false

    # dependencie initialisation
    expect(testFactoryInit).toEqual true
    expect(testGetServices).toEqual true

    # normal validation    
    service.watchField('field1', handlers)
    
    expect(fieldValue).toEqual false
    changeEmail(true)
    expect(fieldValue).toEqual true
    changeEmail(42)
    expect(fieldValue).toEqual 42

    expect(fieldError).toEqual false
    service.validateField('field1')
    expect(fieldError).toEqual true
    changeEmail('fred@mail.com')
    expect(fieldError).toEqual false
    service.validateField('field1')
    expect(fieldError).toEqual false

    changeEmail('wrong')
    expect(fieldError).toEqual false
    service.validateAll()
    expect(fieldError).toEqual true
    changeEmail('fred@mail.com')
    
    # dependencie validation
    changeTest = service.registerField('field2', null)
    expect(service.validateField('field2')).toEqual false
    changeTest('test')
    expect(service.validateField('field2')).toEqual true
    changeTest(false)    
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

  it 'should test submit', inject((registrationService) ->
    service = registrationService(form)
    changeEmail = service.registerField('field1', null)
    changeTest = service.registerField('field2', null)
    
    changeEmail("wrong")
    changeTest("test")
    expect(formSend).toEqual false
    service.submit()
    expect(formSend).toEqual false
    changeEmail("fred.delbos@gmail.com")
    service.submit()
    expect(formSend).toEqual true
  )

  it 'should test reset', inject((registrationService) ->
    value1 = null
    handler1 =
      change: (v) -> value1 = v
    value2 = null
    handler2 =
      change: (v) -> value2 = v
    service = registrationService(form)
    changeEmail = service.registerField('field1', null)
    changeTest = service.registerField('field2', null)

    expect(service.validateAll()).toEqual false
    service.watchField('field1', handler1)
    service.watchField('field2', handler2)
    changeEmail("fred@gmail.com")
    changeTest("test")
    expect(service.validateAll()).toEqual true
    service.reset()
    expect(service.validateAll()).toEqual false
    expect(value1).toEqual null
    expect(value2).toEqual null
    changeEmail("fred@gmail.com")
    changeTest("test")
    expect(service.validateAll()).toEqual true
  )
