## 
## text.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormText', ['CoolFormValueService']).
  directive('coolformText', (valueService) ->

    l = (scope) ->
      scope.value = if scope.field.value? then scope.field.value else ""
      valueService(scope, scope.field)
      

    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.text
      link: l
    }
  )
