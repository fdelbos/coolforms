## 
## submit.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformSubmit', (networkService)->

    l = (scope) ->
      # scope.submit = -> scope.form.submit()
      # scope.reset = -> scope.form.reset()

    return {
      restrict: 'E'
      scope:
        form: '='
      template: templates.submit
      link: l
    }
  )
