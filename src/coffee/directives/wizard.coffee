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

      scope.moveTo = (index) ->
        if validatePage(scope.current) is true then scope.current = index

      scope.moveToNext = ->
        scope.moveTo(scope.current + 1)

      scope.isCurrent = (index) ->
        if scope.current == index then true else false
      
      scope.isLast = ->
        if scope.current == scope.definition.pages.length - 1 then true else false

      scope.nextTitle = ->
        if scope.current + 1 < scope.definition.pages.length
          scope.definition.pages[scope.current + 1].title

      scope.errorsOnPage = (p) -> !$.isEmptyObject scope.errors[p]

      watch = (page, fieldName) ->
        scope.service.watchField(fieldName,
          () -> delete scope.errors[page][fieldName] 
          (e) -> scope.errors[page][fieldName] = e)
          
      scope.errors = []
      pageFields = []
      p = 0
      for page in scope.definition.pages
        scope.errors[p] = {}
        pageFields[p] = []
        for line in page.lines
          for field in line.fields
            pageFields[p].push(field.name)
            watch(p, field.name)
        p += 1

    return {
      restrict: 'E'
      scope:
        definition: '='
        service: '='
      template: templates.wizard
      link: l
    }
  )
