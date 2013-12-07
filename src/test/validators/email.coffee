## 
## email.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  5 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'email tests', ->

  beforeEach(module('CoolFormValidators'))

  it 'validate a correct email', inject((emailValidator) ->
    expect(emailValidator.validator('f', {'f':'fred.delbos@gmail.com'})).toEqual true
    expect(emailValidator.validator('f', {'f':'fred@mail.oko.xasxa.com'})).toEqual true
  )

  it 'wrong email', inject((emailValidator) ->
    expect(emailValidator.validator('f', {'f': null})).toEqual false
    expect(emailValidator.validator('f', {})).toEqual false
    expect(emailValidator.validator('f', {'f': '  '})).toEqual false
    expect(emailValidator.validator('f', {'f': 42})).toEqual false
  )
  
  it 'incorrect emails', inject((emailValidator) ->
    expect(emailValidator.validator('f', {'f': "dadsa.com"})).toEqual false
    expect(emailValidator.validator('f', {'f': "dadsa@com"})).toEqual false
    expect(emailValidator.validator('f', {'f': "@dasda.com"})).toEqual false
  )

