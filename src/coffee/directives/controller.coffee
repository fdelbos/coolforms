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

      scope.loadingError = false
      display_error = ->
        scope.loadingError = true
        scope.$apply()

      setCB = (f) ->
        if scope.before? then f.userCB.before = scope.before
        if scope.success? then f.userCB.success = scope.success
        if scope.error? then f.userCB.error = scope.error
        if scope.failure? then f.userCB.failure = scope.failure
        if scope.send?
          scope.send(success, error) = ->
            f.submit(success, error)

      
    
      load = ->
        networkService().getJSON(scope.url, display_error).then((definition) ->
          scope.form = coreService(definition)
          setCB(scope.form)
          scope.loadingError = false
        )
            
      scope.reload = load
                
      if scope.url? then load()
      else if scope.definition?
        scope.form = coreService(scope.definition)
        setCB(scope.form)

                                 
    return {
      restrict: 'E'
      scope:
        url: '@?'
        definition: '=?'
        before: '=?'
        success: '=?'
        error: '=?'
        failure: '=?'
        send: '=?'
      template: $templateCache.get('coolForm.controller')
      link: l
      replace: true
    }
  )
