## 
## line.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformLine', ($templateCache) ->

    l = (scope, elem, attr) ->
        
    return {
      restrict: 'E'
      scope:
        line: '='
      template: $templateCache.get('coolForm.line')
      link: l
    }
  )
