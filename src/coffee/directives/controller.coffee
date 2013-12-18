## 
## controller.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolForm').
  directive('coolform', ($templateCache, networkService, coreService) ->

    l = (scope, elem, attr) ->

      scope.error = false
      display_error = ->
        scope.error = true
        scope.$apply()

      load = ->
        networkService().getJSON(scope.url, display_error).then((definition) ->
          scope.form = coreService(definition)
        )
        
      if scope.url? then load()
      else if scope.definition?
        scope.form = coreService(scope.definition)
                        
    return {
      restrict: 'E'
      scope:
        url: '@?'
        definition: '=?'
      template: $templateCache.get('coolForm.controller')
      link: l
      replace: true
    }
  )
