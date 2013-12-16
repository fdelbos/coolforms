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
      scope.lbl = scope.field.label
      scope.$watch('field.valid', (v) ->
        switch v
          when true then scope.lbl = scope.field.label
          when false
            if !scope.field.error or scope.field.error == ""
              scope.lbl = scope.field.label
            else scope.lbl = scope.field.error
      )
                        
    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.field
      link: l
    }

  )
