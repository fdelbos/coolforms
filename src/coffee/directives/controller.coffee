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
      
      if scope.url?
        scope.definition = definitionService(scope.url).then((definition) ->
          scope.definition = definition.form
        )
  
      scope.$watch('definition', (v) ->
        console.log v
        if v? and v.pages? then validatorService(scope)
      )

    return {
      restrict: 'E'
      scope:
        url: '@?'
        definition: '=?'
      template: templates.controller
      link: l
      replace: true
    }
  )
