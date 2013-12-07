## 
## validators.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 27 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValidators').
  factory('validators',
    (emailValidator,
    exactSizeValidator,
    maxSizeValidator,
    minSizeValidator,
    notBlankValidator,
    sameAsValidator)->
      validators =
        email:  emailValidator
        exact_size: exactSizeValidator
        max_size: maxSizeValidator
        min_size: minSizeValidator
        not_blank: notBlankValidator
        same_as: sameAsValidator
      return validators
  )

