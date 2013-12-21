## 
## boolean.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 21 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformBoolean', ($templateCache)->

    l = (scope) ->
      scope.value = scope.field.value
      scope.field.onChange.push (v) ->
        if v != scope.value then scope.value = v
      scope.$watch('value', (v, o) -> scope.field.set(v))
      if scope.value == null then scope.value = false

    return {
      restrict: 'E'
      scope:
        field: '='
      template: $templateCache.get('coolForm.boolean')
      link: l
    }
  )
