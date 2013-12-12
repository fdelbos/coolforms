// Generated by CoffeeScript 1.6.3
(function() {
  angular.module('app', ['CoolForm', 'AnotherDemoModule']);

  angular.module('DemoModule', []).factory('demoFactory', function() {
    var validator;
    validator = function(name, values, rule) {
      if ((values[name] != null) && values[name] === 'demo') {
        return true;
      }
      return false;
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('AnotherDemoModule', []).directive('demoDirective', function() {
    var l;
    l = function(scope) {
      var handlers, setValue;
      handlers = {
        change: function(nVal) {
          if (scope.value !== nVal) {
            return scope.value = nVal;
          }
        }
      };
      setValue = scope.service.registerField(scope.field.name, handlers);
      scope.value = scope.field.value ? value : "";
      return scope.$watch('value', function(v, o) {
        return setValue(v);
      });
    };
    return {
      restrict: 'E',
      scope: {
        field: '=',
        service: '='
      },
      template: "<input type=\"text\" ng-model=\"value\"/>",
      link: l
    };
  });

}).call(this);
