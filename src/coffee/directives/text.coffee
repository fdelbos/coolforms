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
      setValue = scope.service.registerField(scope.field.name)
      scope.value = if scope.field.value then value else ""
      scope.$watch('value', (v, o) -> setValue(v))
                    
      setType = (options) ->
        scope.type = "text"
        if options? and options.password? and options.password is true
          scope.type = "password"  
      setType(scope.field.options)

    return {
      restrict: 'E'
      scope:
        field: '='
        service: '='
      template: templates.text
      link: l
    }
  )
