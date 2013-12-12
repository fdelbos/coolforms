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
      scope.errorMsg = false
      scope.show = true  
                  
      eventHandlers =
        ok: () -> scope.error = false
        error: (e) ->
          scope.error = e
          scope.errorMsg = if e == true then false else e    
      scope.service.watchField(scope.field.name, eventHandlers)

      if scope.field.show_when?
        scope.service.display.showWhen(scope.field.show_when,
          (r) -> scope.show = r
        )
      
    return {
      restrict: 'E'
      scope:
        field: '='
        service: '='
      template: templates.field
      link: l
    }

  )
