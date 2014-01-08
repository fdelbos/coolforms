## 
## apps.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('app', ['CoolForm', 'AnotherDemoModule'])

angular.module('app').controller('ctrl', ($scope) ->
    $scope.before = (data) ->
      console.log data
      confirm("Do you want to send?")

    $scope.success = (result, errors) ->
      console.log "success"

    $scope.error = (validate, errors) ->
      console.log "error"

    $scope.doSend = ->
      if $scope.sendCb? then $scope.sendCb()

    $scope.send = () ->
      console.log "pas cool"
)

angular.module('DemoModule', []).factory('demoFactory', ->
  validator = (name, fields, options) ->
    if fields[name].value? and fields[name].value == 'demo' then return true
    return false

  return {
    validator: validator
    init: null
    }
  )

angular.module('AnotherDemoModule', []).directive('demoDirective', ->

  l = (scope) ->
    scope.value = scope.field.value
    scope.field.onChange.push (v) ->
      if v != scope.value then scope.value = v
    scope.$watch('value', (v, o) -> scope.field.set(v))
  
  return {
    restrict: 'E'
    scope:
      field: '='
      service: '='
    template: """<input type="text" ng-model="value"/>"""
    link: l
  }
)
