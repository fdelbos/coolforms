## 
## validators.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  9 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'email tests', ->

  beforeEach(module('CoolFormValidators'))

  it 'find validator', inject((validators, emailValidator) ->
    expect(validators.get('email')).toEqual emailValidator
    expect(validators.get('fred')).toEqual null
  )

  testValidator =
    validator: (name, values, rule) -> true
    init: null

  it 'add a validator', inject((validators) ->
    validators.add('test', testValidator)
    expect(validators.get('test')).toEqual testValidator
  ) 
