## 
## multiple.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 22 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformMultiple', ($templateCache, networkService)->

    l = (scope) ->
      scope.value = scope.field.value

      scope.field.onChange.push (v) ->
        if v != scope.value then scope.value = v
        
      scope.$watch('value', (v, o) ->
        if v == null then v = []
        scope.field.set(v))

      scope.loadingError = false
      display_error = ->
        scope.loadingError = true
        scope.$apply()

      scope.options = []
      if !scope.field.options.type? then scope.field.options.type = "static"

      if scope.field.options.type == "static"
        scope.options = scope.field.options.options
      else if scope.field.options.type == "dynamic"
        networkService().getJSON(scope.field.options.url, display_error).then((v) ->
          scope.options = v
          scope.loadingError = false
        )

    return {
      restrict: 'E'
      scope:
        field: '='
      template: $templateCache.get('coolForm.multiple')
      link: l
    }
  )
