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
      cfg =
        placement: 'bottom'
        trigger: 'manual'
        container: 'body'
        content: ->
          scope.data.error.msg
      pop = $(elem.contents()).children('.coolform-popover').popover(cfg)
      scope.$watch('data.error', (v) ->
        if v.ok is true then pop.popover('hide')
        else
          pop.popover('show')
      )


    return {
      restrict: 'E'
      scope:
        field: '='
      template: templates.field
      link: l
    }

  )