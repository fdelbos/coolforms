## 
## dynamic.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformDynamic', ($compile, directivesService) ->

    l = (scope, elem) ->

      mkTemplate = (name) ->
        """<#{name} field="field"></#{name}>"""

      el = $compile(mkTemplate(scope.field.directive()))(scope)
      elem.append(el)
  
    return {
      restrict: 'E'
      scope:
        field: '='
      link: l
    }
  
  )
