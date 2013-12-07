## 
## minsize.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'minsize tests', ->

  beforeEach(module('CoolFormValidators'))

  rules =
    options:
      size: 4

  it 'validate a correct string', inject((minSizeValidator) ->
    expect(minSizeValidator.validator('f', {'f':'fred.delbos@gmail.com'}, rules)).toEqual true
    expect(minSizeValidator.validator('f', {'f':'1234'}, rules)).toEqual true
    expect(minSizeValidator.validator('f', {'f':'234'}, rules)).toEqual false
    expect(minSizeValidator.validator('f', {'f':'    '}, rules)).toEqual true
  )

  it 'validate wrong stuffs', inject((minSizeValidator) ->
    expect(minSizeValidator.validator('f', {'f':null}, rules)).toEqual false
    expect(minSizeValidator.validator('f', {}, rules)).toEqual false
    expect(minSizeValidator.validator('f', {'f': false}, rules)).toEqual false
  )
