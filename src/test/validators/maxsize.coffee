## 
## maxsize.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec  7 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'maxsize tests', ->

  beforeEach(module('CoolFormValidators'))

  options =
    size: 4

  fields =
    f1:
      value: 'dasdafadatesfewtwf'
    f2:
      value: '1234'
    f3:
      value: '234'
    f4:
      value: '    '
    f5:
      value: null
    f6:
      value: 4242
    f7:
      value: false

  it 'validate ', inject((maxSizeValidator) ->
    expect(maxSizeValidator.validator('f1', fields, options)).toEqual false
    expect(maxSizeValidator.validator('f2', fields, options)).toEqual true
    expect(maxSizeValidator.validator('f3', fields, options)).toEqual true
    expect(maxSizeValidator.validator('f4', fields, options)).toEqual true
    expect(maxSizeValidator.validator('f5', fields, options)).toEqual false
    expect(maxSizeValidator.validator('f6', fields, options)).toEqual false
    expect(maxSizeValidator.validator('f7', fields, options)).toEqual false
  )
