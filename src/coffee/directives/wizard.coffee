## 
## wizard.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 29 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDirectives').
  directive('coolformWizard', ->

    l = (scope) ->
      scope.current = 0

      validatePage = (p) -> scope.service.validateFields(pageFields[p])

      scope.moveTo = (i) ->
        if scope.form.pages[scope.current].validate() is true
          scope.current = i

      scope.moveToNext = ->
        scope.moveTo(scope.current + 1)

      scope.isCurrent = (index) ->
        if scope.current == index then true else false
      
      scope.isLast = ->
        if scope.current + 1 >= scope.form.pages.length then return true
        for i in [(scope.current + 1)..scope.form.pages.length - 1]
          if scope.form.pages[i].display == true then return false
        return true
        

      scope.nextTitle = ->
        if scope.current + 1 < scope.form.pages.length
          scope.form.pages[scope.current + 1].title

    return {
      restrict: 'E'
      scope:
        form: '='
      template: templates.wizard
      link: l
    }
  )
