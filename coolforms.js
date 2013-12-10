(function() {
  var templates;

  angular.module('CoolFormValidators', []);

  angular.module('CoolFormServices', ['CoolFormValidators']);

  angular.module('CoolFormDirectives', ['CoolFormServices']);

  angular.module('CoolForm', ['CoolFormDirectives', 'CoolFormServices']);

  angular.module('CoolFormDirectives').directive('coolformContainer', function() {
    var l;
    l = function(scope) {
      return scope.$watch('definition', function(v) {
        if (!v.pages) {
          return;
        }
        if (v.pages.length > 1) {
          return scope.wizard = true;
        } else {
          return scope.page = scope.definition.pages[0];
        }
      });
    };
    return {
      restrict: 'E',
      scope: {
        definition: '=',
        service: '='
      },
      template: templates.container,
      link: l
    };
  });

  angular.module('CoolForm').directive('coolform', function(networkService, registrationService) {
    var l;
    l = function(scope, elem, attr) {
      if (scope.url != null) {
        scope.definition = networkService().getJSON(scope.url).then(function(definition) {
          return scope.definition = definition.form;
        });
      } else {
        if (scope.form != null) {
          scope.definition = scope.form.form;
          console.log(scope.form);
        }
      }
      return scope.$watch('form', function(v) {
        if ((v != null) && (v.form != null)) {
          scope.definition = scope.form.form;
          return scope.service = registrationService(scope.definition);
        }
      });
    };
    return {
      restrict: 'E',
      scope: {
        url: '@?',
        form: '=?'
      },
      template: templates.controller,
      link: l,
      replace: true
    };
  });

  angular.module('CoolFormDirectives').directive('coolformField', function() {
    var l;
    l = function(scope) {
      var eventHandlers;
      scope.error = false;
      scope.show = true;
      eventHandlers = {
        ok: function() {
          return scope.error = false;
        },
        error: function(e) {
          return scope.error = e;
        }
      };
      scope.service.watchField(scope.field.name, eventHandlers);
      if (scope.field.show_when != null) {
        return scope.service.display.showWhen(scope.field.show_when, function(r) {
          return scope.show = r;
        });
      }
    };
    return {
      restrict: 'E',
      scope: {
        field: '=',
        service: '='
      },
      template: templates.field,
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformHeader', function() {
    return {
      restrict: 'E',
      scope: {
        header: '='
      },
      template: templates.header
    };
  });

  angular.module('CoolFormDirectives').directive('coolformLine', function() {
    var l;
    l = function(scope, elem, attr) {
      var f, _i, _len, _ref, _results;
      _ref = scope.fields;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        f = _ref[_i];
        if (!f.size) {
          _results.push(f.size = 1);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    return {
      restrict: 'E',
      scope: {
        fields: '=',
        service: '='
      },
      template: templates.line,
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformPage', function() {
    return {
      restrict: 'E',
      scope: {
        page: '=',
        service: '='
      },
      template: templates.page
    };
  });

  angular.module('CoolFormDirectives').directive('coolformSubmit', function(networkService) {
    var l;
    l = function(scope) {
      scope.submit = function() {
        return scope.service.submit();
      };
      return scope.reset = function() {
        return scope.service.reset();
      };
    };
    return {
      restrict: 'E',
      scope: {
        definition: '=',
        service: '='
      },
      template: templates.submit,
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformText', function() {
    var l;
    l = function(scope) {
      var handlers, setType, setValue;
      handlers = {
        change: function(nVal) {
          if (scope.value !== nVal) {
            return scope.value = nVal;
          }
        }
      };
      setValue = scope.service.registerField(scope.field.name, handlers);
      scope.value = scope.field.value ? value : "";
      scope.$watch('value', function(v, o) {
        return setValue(v);
      });
      setType = function(options) {
        scope.type = "text";
        if ((options != null) && (options.password != null) && options.password === true) {
          return scope.type = "password";
        }
      };
      return setType(scope.field.options);
    };
    return {
      restrict: 'E',
      scope: {
        field: '=',
        service: '='
      },
      template: templates.text,
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformWizard', function() {
    var l;
    l = function(scope) {
      var field, line, p, page, pageFields, validatePage, watch, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
      scope.current = 0;
      validatePage = function(p) {
        return scope.service.validateFields(pageFields[p]);
      };
      scope.moveTo = function(index) {
        if (validatePage(scope.current) === true) {
          return scope.current = index;
        }
      };
      scope.moveToNext = function() {
        return scope.moveTo(scope.current + 1);
      };
      scope.isCurrent = function(index) {
        if (scope.current === index) {
          return true;
        } else {
          return false;
        }
      };
      scope.isLast = function() {
        if (scope.current === scope.definition.pages.length - 1) {
          return true;
        } else {
          return false;
        }
      };
      scope.nextTitle = function() {
        if (scope.current + 1 < scope.definition.pages.length) {
          return scope.definition.pages[scope.current + 1].title;
        }
      };
      scope.errorsOnPage = function(p) {
        return !$.isEmptyObject(scope.errors[p]);
      };
      watch = function(page, fieldName) {
        var events;
        events = {
          ok: function() {
            return delete scope.errors[page][fieldName];
          },
          error: function(e) {
            return scope.errors[page][fieldName] = e;
          }
        };
        return scope.service.watchField(fieldName, events);
      };
      scope.errors = [];
      pageFields = [];
      p = 0;
      _ref = scope.definition.pages;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        page = _ref[_i];
        scope.errors[p] = {};
        pageFields[p] = [];
        _ref1 = page.lines;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          line = _ref1[_j];
          _ref2 = line.fields;
          for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
            field = _ref2[_k];
            pageFields[p].push(field.name);
            watch(p, field.name);
          }
        }
        _results.push(p += 1);
      }
      return _results;
    };
    return {
      restrict: 'E',
      scope: {
        definition: '=',
        service: '='
      },
      template: templates.wizard,
      link: l
    };
  });

  angular.module('CoolFormValidators').factory('emailValidator', function() {
    var validator;
    validator = function(name, values, rule) {
      var p;
      if ((values[name] == null) || typeof values[name] !== "string") {
        return false;
      }
      p = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
      if ((values[name] != null) && values[name].match(p)) {
        return true;
      } else {
        return false;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('exactSizeValidator', function() {
    var validator;
    validator = function(name, values, rule) {
      if ((values[name] == null) || typeof values[name] !== "string") {
        return false;
      }
      if (values[name].length === rule.options.size) {
        return true;
      } else {
        return false;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('maxSizeValidator', function() {
    var validator;
    validator = function(name, values, rule) {
      if ((values[name] == null) || typeof values[name] !== "string") {
        return false;
      }
      if (values[name].length <= rule.options.size) {
        return true;
      } else {
        return false;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('minSizeValidator', function() {
    var validator;
    validator = function(name, values, rule) {
      if ((values[name] == null) || typeof values[name] !== "string") {
        return false;
      }
      if (values[name].length >= rule.options.size) {
        return true;
      } else {
        return false;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('notBlankValidator', function() {
    var validator;
    validator = function(name, values, rule) {
      var v;
      v = values[name];
      if (v === void 0 || v === null) {
        return false;
      }
      if (typeof v === "boolean" && v === true || v === false) {
        return true;
      }
      if (typeof v === "number") {
        return true;
      }
      if (typeof v === "string") {
        if ((v.replace(/^\s+|\s+$/g, "")).length > 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('sameAsValidator', function() {
    var init, validator;
    validator = function(name, values, rule) {
      if (values[name] === values[rule.options.field]) {
        return true;
      } else {
        return false;
      }
    };
    init = function(name, rule, services) {
      return services.watchField(rule.options.field, null, null, function(value) {
        return services.validateField(name);
      });
    };
    return {
      validator: validator,
      init: init
    };
  });

  angular.module('CoolFormValidators').factory('validators', function(emailValidator, exactSizeValidator, maxSizeValidator, minSizeValidator, notBlankValidator, sameAsValidator) {
    var add, get, validators;
    validators = {
      email: emailValidator,
      exact_size: exactSizeValidator,
      max_size: maxSizeValidator,
      min_size: minSizeValidator,
      not_blank: notBlankValidator,
      same_as: sameAsValidator
    };
    get = function(name) {
      if (validators[name] != null) {
        return validators[name];
      }
      return null;
    };
    add = function(name, validator) {
      return validators[name] = validator;
    };
    return {
      get: get,
      add: add
    };
  });

  angular.module('CoolFormServices').factory('displayService', function() {
    return function(events, values) {
      var display, register, shouldHide, shouldShow, valueIn;
      valueIn = function(value, l) {
        var e, _i, _len;
        for (_i = 0, _len = l.length; _i < _len; _i++) {
          e = l[_i];
          if (e === value) {
            return true;
          }
        }
        return false;
      };
      shouldShow = function(conds) {
        var cond, _i, _len;
        for (_i = 0, _len = conds.length; _i < _len; _i++) {
          cond = conds[_i];
          if (valueIn(values[cond.field], cond.values)) {
            return true;
          }
        }
        return false;
      };
      shouldHide = function(conds) {
        return !shouldShow(conds);
      };
      register = function(conds, cb, checker) {
        var cond, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = conds.length; _i < _len; _i++) {
          cond = conds[_i];
          _results.push(events.watchField(cond.field, {
            change: function() {
              return cb(checker(conds));
            }
          }));
        }
        return _results;
      };
      display = {
        showWhen: function(conds, cb) {
          return register(conds, cb, shouldShow);
        },
        hideWhen: function(conds, cb) {
          return register(conds, cb, shouldHide);
        }
      };
      return display;
    };
  });

  angular.module('CoolFormServices').factory('eventService', function() {
    return function() {
      var event, handle, handlers, watchField;
      handlers = {
        ok: {},
        error: {},
        change: {}
      };
      handle = function(fieldName, type, data) {
        var fn, _i, _len, _ref, _results;
        if ((handlers[type] == null) || (handlers[type][fieldName] == null)) {
          return;
        }
        _ref = handlers[type][fieldName];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          fn = _ref[_i];
          if (data != null) {
            _results.push(fn(data));
          } else {
            _results.push(fn());
          }
        }
        return _results;
      };
      watchField = function(fieldName, eventHandlers) {
        var type, _results;
        _results = [];
        for (type in eventHandlers) {
          if (handlers[type] != null) {
            if (handlers[type][fieldName] == null) {
              handlers[type][fieldName] = [];
            }
            _results.push(handlers[type][fieldName].push(eventHandlers[type]));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      event = {
        handle: handle,
        watchField: watchField
      };
      return event;
    };
  });

  angular.module('CoolFormServices').factory('networkService', function($q) {
    return function() {
      var getJSON, net, sendForm;
      getJSON = function(url) {
        var deferred;
        deferred = $q.defer();
        $.getJSON(url, function(data) {
          return deferred.resolve(data);
        });
        return deferred.promise;
      };
      sendForm = function(params, data) {
        var cfg;
        cfg = {
          type: params.method,
          url: params.url,
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          data: data,
          success: params.success,
          error: params.error,
          headers: params.headers
        };
        return $.ajax(cfg);
      };
      net = {
        getJSON: getJSON,
        sendForm: sendForm
      };
      return net;
    };
  });

  angular.module('CoolFormServices').factory('registrationService', function(validationService, eventService, networkService, displayService) {
    return function(form) {
      var changeValue, display, events, registerDependencies, registerField, reset, services, setFields, submit, validation, values;
      events = eventService();
      validation = validationService(events);
      values = {};
      display = displayService(events, values);
      setFields = function(pages) {
        var f, line, p, page, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _results;
        p = 0;
        _results = [];
        for (_i = 0, _len = pages.length; _i < _len; _i++) {
          page = pages[_i];
          _ref = page.lines;
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            line = _ref[_j];
            _ref1 = line.fields;
            for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
              f = _ref1[_k];
              validation.initValidation(f, services);
            }
          }
          _results.push(p += 1);
        }
        return _results;
      };
      changeValue = function(fieldName, value) {
        values[fieldName] = value;
        validation.removeError(fieldName);
        return events.handle(fieldName, "change", value);
      };
      registerField = function(fieldName, eventHandlers) {
        events.watchField(fieldName, eventHandlers);
        return function(value) {
          return changeValue(fieldName, value);
        };
      };
      submit = function() {
        var params;
        if (validation.validateAll(values) === false) {
          return;
        }
        params = {
          url: form.url,
          method: form.method != null ? form.method : "POST",
          success: function() {
            return console.log("success");
          },
          error: function() {
            return console.log("error");
          },
          headers: form.headers != null ? form.headers : {}
        };
        return networkService().sendForm(params, values);
      };
      registerDependencies = function(deps) {
        var d, f, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = deps.length; _i < _len; _i++) {
          d = deps[_i];
          f = angular.injector([d.module]).get(d.factory);
          if (d.type === "validator") {
            _results.push(validation.add(d.name, f));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      reset = function() {
        var k, _i, _len, _ref, _results;
        _ref = Object.keys(values);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          k = _ref[_i];
          _results.push(changeValue(k, null));
        }
        return _results;
      };
      services = {
        display: display,
        registerField: registerField,
        validateField: function(fieldName) {
          return validation.validateField(fieldName, values);
        },
        validateFields: function(fieldList) {
          return validation.validateFields(fieldList, values);
        },
        validateAll: function() {
          return validation.validateAll(values);
        },
        watchField: events.watchField,
        reset: reset,
        submit: submit
      };
      if (form.dependencies != null) {
        registerDependencies(form.dependencies);
      }
      setFields(form.pages);
      return services;
    };
  });

  angular.module('CoolFormServices').factory('validationService', function(validators) {
    return function(events) {
      var errors, fields, initValidation, removeError, setError, validateAll, validateField, validateFields;
      errors = {};
      fields = {};
      removeError = function(fieldName) {
        delete errors[fieldName];
        events.handle(fieldName, "ok");
        return true;
      };
      setError = function(fieldName, msg) {
        errors[fieldName] = msg;
        events.handle(fieldName, "error", msg);
        return false;
      };
      initValidation = function(field, services) {
        fields[field.name] = field;
        if (field.validation != null) {
          return field.validation.map(function(rule) {
            var vl;
            vl = validators.get(rule.validator);
            if ((vl != null) && (vl.init != null)) {
              return vl.init(field.name, rule, services);
            }
          });
        }
      };
      validateField = function(fieldName, values) {
        var field, rule, vl, _i, _len, _ref;
        field = fields[fieldName];
        if (field.validation != null) {
          _ref = field.validation;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            rule = _ref[_i];
            vl = validators.get(rule.validator);
            if (vl && (vl.validator != null)) {
              if (!vl.validator(fieldName, values, rule)) {
                return setError(fieldName, rule.options.message);
              }
            }
          }
        }
        return removeError(fieldName);
      };
      validateFields = function(fieldList, values) {
        var f, result, _i, _len;
        result = true;
        for (_i = 0, _len = fieldList.length; _i < _len; _i++) {
          f = fieldList[_i];
          if (!validateField(f, values)) {
            result = false;
          }
        }
        return result;
      };
      validateAll = function(values) {
        return validateFields(Object.keys(fields), values);
      };
      return {
        removeError: removeError,
        initValidation: initValidation,
        validateField: validateField,
        validateFields: validateFields,
        validateAll: validateAll,
        add: function(validatorName, factory) {
          return validators.add(validatorName, factory);
        }
      };
    };
  });

  templates = {
    container: "<form>\n  <div class=\"container-fluid\">\n\n<div ng-if=\"definition.title || definition.description\" class=\"row\">\n  <h3 ng-if=\"definition.title\">{{ definition.title }}</h3>\n  <div ng-if=\"definition.description\" class=\"well well-sm\">\n	{{ definition.description }}\n  </div>\n</div>\n\n<coolform-wizard ng-if=\"wizard\" definition=\"definition\" service=\"service\">\n</coolform-wizard>\n\n<div ng-if=\"page\">\n  <coolform-page page=\"page\" service=\"service\"></coolform-page>\n  <div class=\"row\">\n	<coolform-submit definition=\"definition\" service=\"service\">\n	</coolform-submit>\n  </div>\n</div>	\n\n  </div>\n</form>",
    controller: "<div>\n  <div ng-if=\"!definition\">\n  	loading {{ url }}\n  </div>\n\n  <div ng-if=\"definition\">\n<coolform-container definition=\"definition\" service=\"service\">\n</coolform-container>\n  </div>\n</div>",
    field: "<div class=\"form-group\" ng-show=\"show\" ng-class=\"{'has-error': error}\" >\n\n  <label class=\"control-label\" for=\"email\">\n{{ field.label }}\n  </label>\n  \n  <div class=\"coolform-popover\">\n<ng-switch on=\"field.type\">\n  <coolform-text ng-switch-when=\"text\" field=\"field\" service=\"service\"></coolform-text>\n</ng-switch>\n  </div>\n  \n  <p ng-show=\"error\" class=\"help-block\">{{ error }}</p>\n  <p ng-hide=\"error\" class=\"help-block\" ng-if=\"field.help\">{{ field.help }}</p>\n    \n</div>",
    header: "<div>\n<h4 class=\"text-muted\">{{ header.title }}</h4>\n<div>{{ header.description }}</div>\n</div>",
    line: "<div ng-repeat=\"field in fields\">\n  <div class=\"col-md-{{ field.size * 3 }}\" >\n<coolform-field \n   field=\"field\" \n   service=\"service\">\n</coolform-field>\n  </div>\n</div>",
    page: "<div ng-if=\"page.title || page.description\" class=\"row\">\n<h4 ng-if=\"page.title\" class=\"text-primary\">{{ page.title }}</h4>\n<div ng-if=\"page.description\">{{ page.description }}</div>\n</div>\n\n<div class=\"row\" ng-repeat=\"line in page.lines\">\n<coolform-header ng-if=\"line.header\" header=\"line.header\"></coolform-header>\n<coolform-line \n	 ng-if=\"line.fields\" \n	 fields=\"line.fields\" \n	 service=\"service\">\n</coolform-line>\n</div>",
    submit: "<div class=\"well well-sm\">\n  <button \n ng-click=\"submit()\" \n type=\"button\" \n class=\"btn btn-primary\">\n{{ definition.submit }}\n  </button>\n  <button \n ng-click=\"reset()\"\n type=\"button\" \n class=\"btn btn-default\">\n{{ definition.reset }}\n  </button>\n</div>",
    text: "<input \ntype=\"{{ type }}\" \nclass=\"form-control\" \nplaceholder=\"{{ field.placeholder }}\" \nng-model=\"value\"/>",
    wizard: "<div class=\"row\">\n  <ul class=\"nav nav-tabs\">\n<li ng-repeat=\"page in definition.pages\" ng-class=\"{active: isCurrent($index)}\">\n  <a ng-click=\"moveTo($index)\"\n	 ng-class=\"{'text-danger': errorsOnPage($index)}\"\n	 href=\"\">\n	{{ page.title }}\n  </a>\n<li>\n  </ul>\n</div>\n\n<div ng-repeat=\"page in definition.pages\">\n  <coolform-page ng-show=\"isCurrent($index)\" page=\"page\" service=\"service\">\n  </coolform-page>\n</div>\n\n<div ng-hide=\"isLast()\" class=\"well well-sm\">\n  <button ng-click=\"moveToNext()\" \n	  type=\"button\"\n	  class=\"btn btn-primary\"\n	  ng-class=\"{disabled: errorsOnPage(current)}\">\n<span class=\"glyphicon glyphicon-arrow-right\"></span>\n{{ nextTitle() }}\n  </button>\n</div>\n\n<coolform-submit ng-show=\"isLast()\" service=\"service\" definition=\"definition\">\n</coolform-submit>"
  };

}).call(this);
