## 
## notblank.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'notblank tests', ->

  beforeEach(module('CoolFormValidators'))

  it 'for a string', inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {'f': 'fred'}, null)).toEqual true
    expect(notBlankValidator.validator('f', {'f': '   \t\na\t '}, null)).toEqual true
  )

  it 'with blank field' , inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {'f': ''}, null)).toEqual false
  )

  it 'blank field with whitespaces' , inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {'f': '   '}, null)).toEqual false
    expect(notBlankValidator.validator('f', {'f': '   \t\n\t '}, null)).toEqual false
  )

  it 'with numbers' , inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {'f': 0}, null)).toEqual true
    expect(notBlankValidator.validator('f', {'f': 42}, null)).toEqual true
  )

  it 'with booleans' , inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {'f': true}, null)).toEqual true
    expect(notBlankValidator.validator('f', {'f': false}, null)).toEqual true
  )

  it 'with null stuffs' , inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f', {}, null)).toEqual false
    expect(notBlankValidator.validator('f', {'f': null}, null)).toEqual false
    expect(notBlankValidator.validator('f', {'f': undefined}, null)).toEqual false
  )
