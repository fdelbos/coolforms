## 
## apps.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('app', ['CoolForm', 'AnotherDemoModule'])

angular.module('DemoModule', []).factory('demoFactory', ->
  validator = (name, values, rule) ->
    if values[name]? and values[name] == 'demo' then return true
    return false

  return {
    validator: validator
    init: null
    }
  )

angular.module('AnotherDemoModule', []).directive('demoDirective', ->

  l = (scope) ->
    handlers =
      change: (nVal) ->
        if scope.value != nVal then scope.value = nVal
    setValue = scope.service.registerField(scope.field.name, handlers)
    scope.value = if scope.field.value then value else ""
    scope.$watch('value', (v, o) -> setValue(v))
            
  return {
    restrict: 'E'
    scope:
      field: '='
      service: '='
    template: """<input type="text" ng-model="value"/>"""
    link: l
  }
)
