## 
## dynamic.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformDynamic', ($compile) ->

    l = (scope, elem) ->

      mkTemplate = (name) ->
        """<#{name} field="field" service="service"></#{name}>"""
        
      type = scope.service.directives.get(scope.field.type)
      el = $compile(mkTemplate(type))(scope)
      elem.append(el)
  
    return {
      restrict: 'E'
      scope:
        field: '='
        service: '='
      template: ""
      link: l
      }

  )
