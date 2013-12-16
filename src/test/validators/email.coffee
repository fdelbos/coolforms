## 
## email.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  5 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'email tests', ->

  beforeEach(module('CoolFormValidators'))

  fields =
    f1:
      value: 'fred.delbos@gmail.com'
    f2:
      value: 'fred@mail.oko.xasxa.com'
    f3:
      value: null
    f4: {}
    f5:
      value: 42
    f6:
      'daasdasd.com'
    f7:
      'dasda@asda'
    f8:
      '@asda.com'


  it 'validate a correct email', inject((emailValidator) ->
    expect(emailValidator.validator('f1', fields)).toEqual true
    expect(emailValidator.validator('f2', fields)).toEqual true
  )

  it 'wrong email', inject((emailValidator) ->
    expect(emailValidator.validator('f3', fields)).toEqual false
    expect(emailValidator.validator('f4', fields)).toEqual false
    expect(emailValidator.validator('f5', fields)).toEqual false
    expect(emailValidator.validator('f6', fields)).toEqual false
    expect(emailValidator.validator('f7', fields)).toEqual false
    expect(emailValidator.validator('f8', fields)).toEqual false
    
  )
