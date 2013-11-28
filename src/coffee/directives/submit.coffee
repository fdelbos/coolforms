## 
## submit.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformSubmit', (submitService) ->

    l = (scope) ->
      scope.submit =  -> submitService(scope)

    return {
      restrict: 'E'
      scope:
        definition: '='
      template: templates.submit
      link: l
    }
  )
