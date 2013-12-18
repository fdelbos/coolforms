## 
## submit.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 28 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformSubmit', ($templateCache, networkService)->

    l = (scope) ->

      scope.submitError = false
      submitError = ->
        scope.submitError = true
        scope.$apply()
      scope.submit = -> scope.form.submit(null, submitError)
      
    return {
      restrict: 'E'
      scope:
        form: '='
      template: $templateCache.get('coolForm.submit')
      link: l
    }
  )
