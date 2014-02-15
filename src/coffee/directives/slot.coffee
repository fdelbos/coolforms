## 
## slot.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Feb 14 2014.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformSlot', ($templateCache) ->

    l = (scope, elem, attr) ->
      scope.span = -> 12 / scope.lsize * scope.slot.span
        
    return {
      restrict: 'E'
      scope:
        lsize: '='
        slot: '='
      template: $templateCache.get('coolForm.slot')
      link: l
    }
  )
