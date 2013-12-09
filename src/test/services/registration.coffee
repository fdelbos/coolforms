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
    pages: [
      lines:[
        fields:[
          name: "field1"
          type: "text",
          label: "field 1"
          validation: [
            validator:"email"
            options: [
              message: "not an email"
              ]
            ]
          ]
        ]
      ]

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

    expect(formSend).toEqual false
    service.submit()
    expect(formSend).toEqual false
    changeValue('fred@mail.com')
    service.submit()
    expect(formSend).toEqual true
  )
  
