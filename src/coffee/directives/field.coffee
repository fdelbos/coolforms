## 
## field.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformField', ->

    l = (scope, elem) ->
      scope.data =
        error:
          ok: true
          msg: null
      
    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.field
      link: l
    }

  )