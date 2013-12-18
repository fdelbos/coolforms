## 
## error_loading.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 18 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolForm').
  directive('coolformErrorLoading', ($templateCache) ->

    l = (scope) ->
      scope.load = ->
        scope.reload()
    
    return {
      restrict: 'E'
      scope:
        reload: '='
      template: $templateCache.get('coolForm.error_loading')
      replace: true
      link: l
    }
  )
