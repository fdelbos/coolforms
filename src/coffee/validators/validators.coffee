## 
## validators.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 27 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validators',
    (validatorEmail,
    validatorMinSize,
    validatorNotBlank,
    validatorSameAs)->
      validators =
        email:  validatorEmail
        min_size: validatorMinSize
        not_blank: validatorNotBlank
        same_as: validatorSameAs
      return validators
  )

