## 
## line.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformLine', () ->

    l = (scope, elem, attr) ->        
      for f in scope.fields
        if !f.size then f.size = 1
  
    return {
      restrict: 'E'
      scope:
        fields: '='
      template: templates.line
      link: l
    }
  )
