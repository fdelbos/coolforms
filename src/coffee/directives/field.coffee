##
## field.coffee
##
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
##

angular.module('CoolFormDirectives').
  directive('coolformField', ->

    l = (scope) ->
      scope.error = false
      scope.service.watchField(scope.field.name,
        () -> scope.error = false,
        (e) -> scope.error = e)

                  
    return {
      restrict: 'E'
      scope:
        field: '='
        service: '='
      template: templates.field
      link: l
    }

  )
