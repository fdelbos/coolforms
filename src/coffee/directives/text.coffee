## 
## text.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformText', ->

    l = (scope) ->
      scope.value = scope.field.value
      scope.field.onChange.push (v) ->
        if v != scope.value then scope.value = v
        
      scope.$watch('value', (v, o) -> scope.field.set(v))

      scope.type = "text"
      if scope.field.options.type?
        scope.type =  scope.field.options.type

    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.text
      link: l
    }
  )
