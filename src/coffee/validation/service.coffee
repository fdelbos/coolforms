## 
## service.coffee
## 
## Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 27 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormValueService', []).
  factory('valueService', ->
    return (scope, field, onOk, onError) ->
    
      scope.$emit('register', field)

      scope.$watch('value', (v, o) ->
        if v == o then return
        scope.$emit('valueChange', {name: field.name, value: scope.value})
      )

      scope.$on('validation', (event, args) ->
        event.stopPropagation()
        if args.ok
          scope.error = false
          if onOk? then onOk()
        else
          scope.error = args.msg
          if onError then onError(args.msg)
      )
  )

angular.module('CoolFormValidatorService', []).
  factory('validationService', ->
    

  )