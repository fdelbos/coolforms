## 
## sameas.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'sameas tests', ->

  beforeEach(module('CoolFormValidators'))

  rule =
    options:
      field: 't'
  
  it 'should work', inject((sameAsValidator) ->
    expect(sameAsValidator.validator('f', {'f': 'fred', 't': 'fred'}, rule)).toEqual true
    expect(sameAsValidator.validator('f', {'f': '', 't': ''}, rule)).toEqual true
    expect(sameAsValidator.validator('f', {'f': null, 't': null}, rule)).toEqual true
    expect(sameAsValidator.validator('f', {'f': false, 't': false}, rule)).toEqual true
    expect(sameAsValidator.validator('f', {'f': 42, 't': 42}, rule)).toEqual true
  )

  it 'should not work', inject((sameAsValidator) ->
    expect(sameAsValidator.validator('f', {'f': 'fred', 't': 'frey'}, rule)).toEqual false
    expect(sameAsValidator.validator('f', {'f': ' ', 't': ''}, rule)).toEqual false
    expect(sameAsValidator.validator('f', {'f': 'lol', 't': null}, rule)).toEqual false
    expect(sameAsValidator.validator('f', {'f': true, 't': false}, rule)).toEqual false
    expect(sameAsValidator.validator('f', {'f': 41, 't': 42}, rule)).toEqual false
  )
