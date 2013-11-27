## 
## controller.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 23 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormDefinitionResolver', []).
  factory('DefinitionResolver', ($q) ->
    return (url) ->
      deferred = $q.defer()
      $.getJSON(url, (data) ->
        deferred.resolve(data))
      return deferred.promise
  )

angular.module('CoolForm', ['CoolFormContainer', 'CoolFormDefinitionResolver']).
  directive('coolform', (DefinitionResolver) ->

    l = (scope, elem, attr) ->
      scope.definition = null
      if scope.url then scope.definition = DefinitionResolver(scope.url).then((definition) ->
        scope.definition = definition.form
      )
  
      make_data = (sections) ->
        values = {}
        errors = {}
        for section in sections
          for line in section.lines
            for field in line.fields
              if field.value? then values[field.name] = field.value else values[field.name] = null
              errors[field.name] = null
        scope.data =
          values: values
          errors: errors
        console.log scope.data

      scope.$watch('definition', (v) ->
        if !v.sections then return else make_data(v.sections)
      )

    return {
      restrict: 'E'
      scope:
        url: '@'
      template: templates.controller
      link: l
      replace: true
    }
  )
