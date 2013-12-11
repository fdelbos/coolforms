## 
## dynamic.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 11 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'dynamic directive tests', ->

  beforeEach(module('CoolFormServices'))

  form =
    name: "form"
    action: "/"
    dependencies: [
      type: 'directive'
      field_type: 'text'
      name: 'test-text'
      ]
    pages: [
      lines:[
        fields:[
          {
            name: "field"
            type: "text"
            label: "field"
            validation: [
              validator:"email"
              options: [
                message: "not an email"
                ]
              ]
            }
          ]
        ]
      ]

  # directiveLoaded = false
  # angular.module('TestModule', []).directive('testText', ->
  #     l = (scope) ->
  #       handlers =
  #         change: (nVal) ->
  #           if scope.value != nVal then scope.value = nVal
  #       dump "hello"
  #       directiveLoaded = true
  #       setValue = scope.service.registerField(scope.field.name, handlers)
  #       scope.value = if scope.field.value then value else ""
  #       scope.$watch('value', (v, o) -> setValue(v))
        

  #     return {
  #       restrict: 'E'
  #       scope:
  #         field: '='
  #         service: '='
  #       template: """<input type="text" ng-model="value"/>"""
  #       link: l
  #     }
  #   )

  it 'load directive and override default text input', inject((registrationService) ->
    service = registrationService(form)
    expect(service.directives.get('text')).toEqual('test-text')
  )

  
