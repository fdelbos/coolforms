## 
## notblank.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'notblank tests', ->

  beforeEach(module('CoolFormValidators'))

  fields =
    f1:
      value: 'fred'
    f2:
      value: '   \t\na\t '
    f3:
      value: ''
    f4:
      value: '    '
    f5:
      value: '    \t\n\n \n\n \t\t\n  '
    f6:
      value: 0
    f7:
      value: 42
    f8:
      value: true
    f9:
      value: false
    f10:
      value: null
    f11:
      value: undefined

  it 'for a string', inject((notBlankValidator) ->
    expect(notBlankValidator.validator('f1', fields)).toEqual true
    expect(notBlankValidator.validator('f2', fields)).toEqual true
    expect(notBlankValidator.validator('f3', fields)).toEqual false
    expect(notBlankValidator.validator('f4', fields)).toEqual false
    expect(notBlankValidator.validator('f5', fields)).toEqual false
    expect(notBlankValidator.validator('f6', fields)).toEqual true
    expect(notBlankValidator.validator('f7', fields)).toEqual true
    expect(notBlankValidator.validator('f8', fields)).toEqual true
    expect(notBlankValidator.validator('f9', fields)).toEqual true
    expect(notBlankValidator.validator('f10', fields)).toEqual false
    expect(notBlankValidator.validator('f11', fields)).toEqual false
  )
