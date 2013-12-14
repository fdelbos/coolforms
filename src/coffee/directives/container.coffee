## 
## container.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformContainer', () ->

    l = (scope) ->
      scope.$watch('form', (v) ->
        if !v.pages then return
        if v.pages.length > 1
          scope.wizard = true
        else
          scope.page = scope.form.pages[0]
      )
        
    return {
      restrict: 'E'
      scope:
        form: '='
      template: templates.container
      link: l
    }
  )
