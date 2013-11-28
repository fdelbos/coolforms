## 
## controller.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 


angular.module('CoolForm').
  directive('coolform', (definitionService, validatorService) ->

    l = (scope, elem, attr) ->
      scope.definition = null
      if scope.url then scope.definition = definitionService(scope.url).then((definition) ->
        scope.definition = definition.form
      )
  
      scope.$watch('definition', (v) ->
        if !v.pages then return else validatorService(scope)
      )

    return {
      restrict: 'E'
      scope:
        url: '@'
      template: templates.controller
      link: l
      replace: true
    }
  )
