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

      else
        if scope.form?
          scope.definition = scope.form.form
          console.log scope.form
        
      scope.$watch('form', (v) ->
        if v? and v.form?
          scope.definition = scope.form.form
          validatorService(scope)
      )

    return {
      restrict: 'E'
      scope:
        url: '@?'
        form: '=?'
      template: templates.controller
      link: l
      replace: true
    }
  )
