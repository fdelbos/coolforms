## 
## wizard.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 29 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformWizard', () ->

    l = (scope) ->
      scope.current = 0
  
      scope.moveTo = (index) ->
        scope.current = index

      scope.moveToNext = ->
        scope.current += 1

      scope.isCurrent = (index) ->
        if scope.current == index then true else false
      
      scope.isLast = ->
        if scope.current == scope.definition.pages.length - 1 then true else false

      scope.nextTitle = ->
        if scope.current + 1 < scope.definition.pages.length
          scope.definition.pages[scope.current + 1].title

    return {
      restrict: 'E'
      scope:
        definition: '='
      template: templates.wizard
      link: l
    }
  )
