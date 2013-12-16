## 
## sameas.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'sameas tests', ->

  beforeEach(module('CoolFormValidators'))

  options:
    field: 't'

  fields =
    f1:
      value: 'fred'
    f2:
      value: ''
    f3:
      value: null
    f4:
      value: false
    f5:
      value: true
    f6:
      value: undefined
    f8:
      value: 42
    f9:
      value: 0
  
  it 'should work', inject((sameAsValidator) ->
    expect(sameAsValidator.validator('f1', fields, {'field':'f1'})).toEqual true
    expect(sameAsValidator.validator('f1', fields, {'field':'f2'})).toEqual false
    expect(sameAsValidator.validator('f2', fields, {'field':'f1'})).toEqual false
    expect(sameAsValidator.validator('f3', fields, {'field':'f3'})).toEqual true
    expect(sameAsValidator.validator('f3', fields, {'field':'f8'})).toEqual false
    expect(sameAsValidator.validator('f4', fields, {'field':'f4'})).toEqual true
    expect(sameAsValidator.validator('f4', fields, {'field':'f5'})).toEqual false
    expect(sameAsValidator.validator('f4', fields, {'field':'f6'})).toEqual false
    expect(sameAsValidator.validator('f3', fields, {'field':'f6'})).toEqual false
    expect(sameAsValidator.validator('f8', fields, {'field':'f9'})).toEqual false
  )
