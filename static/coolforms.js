(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  angular.module('CoolFormValidators', []);

  angular.module('CoolFormServices', ['CoolFormValidators']);

  angular.module('CoolFormDirectives', ['CoolFormServices', 'ngSanitize']);

  angular.module('CoolForm', ['CoolFormDirectives', 'CoolFormServices']);

  angular.module('CoolFormDirectives').directive('coolformContainer', function($templateCache) {
    var l;
    l = function(scope) {
      return scope.$watch('form', function(v) {
        if (!v.pages) {
          return;
        }
        if (v.pages.length > 1) {
          return scope.wizard = true;
        } else {
          return scope.page = scope.form.pages[0];
        }
      });
    };
    return {
      restrict: 'E',
      scope: {
        form: '='
      },
      template: $templateCache.get('coolForm.container'),
      link: l
    };
  });

  angular.module('CoolForm').directive('coolform', function($templateCache, networkService, coreService) {
    var l;
    l = function(scope, elem, attr) {
      var display_error, load;
      scope.loadingError = false;
      display_error = function() {
        scope.loadingError = true;
        return scope.$apply();
      };
      load = function() {
        return networkService().getJSON(scope.url, display_error).then(function(definition) {
          scope.form = coreService(definition);
          return scope.loadingError = false;
        });
      };
      scope.reload = load;
      if (scope.url != null) {
        return load();
      } else if (scope.definition != null) {
        return scope.form = coreService(scope.definition);
      }
    };
    return {
      restrict: 'E',
      scope: {
        url: '@?',
        definition: '=?'
      },
      template: $templateCache.get('coolForm.controller'),
      link: l,
      replace: true
    };
  });

  angular.module('CoolFormDirectives').directive('coolformDynamic', function($compile, directivesService) {
    var l;
    l = function(scope, elem) {
      var el, mkTemplate;
      mkTemplate = function(name) {
        return "<" + name + " field=\"field\"></" + name + ">";
      };
      el = $compile(mkTemplate(scope.field.directive()))(scope);
      return elem.append(el);
    };
    return {
      restrict: 'E',
      scope: {
        field: '='
      },
      link: l
    };
  });

  angular.module('CoolForm').directive('coolformErrorLoading', function($templateCache) {
    var l;
    l = function(scope) {
      return scope.load = function() {
        return scope.reload();
      };
    };
    return {
      restrict: 'E',
      scope: {
        reload: '='
      },
      template: $templateCache.get('coolForm.error_loading'),
      replace: true,
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformField', function($templateCache) {
    var l;
    l = function(scope) {
      scope.lbl = scope.field.label;
      return scope.$watch('field.valid', function(v) {
        switch (v) {
          case true:
            return scope.help = scope.field.help;
          case false:
            if (!scope.field.error || scope.field.error === "") {
              return scope.help = scope.field.help;
            } else {
              return scope.help = scope.field.error;
            }
        }
      });
    };
    return {
      restrict: 'E',
      scope: {
        field: '='
      },
      template: $templateCache.get('coolForm.field'),
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformLine', function($templateCache) {
    var l;
    l = function(scope, elem, attr) {};
    return {
      restrict: 'E',
      scope: {
        line: '='
      },
      template: $templateCache.get('coolForm.line'),
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformPage', function($templateCache) {
    return {
      restrict: 'E',
      scope: {
        page: '='
      },
      template: $templateCache.get('coolForm.page')
    };
  });

  angular.module('CoolFormDirectives').directive('coolformSubmit', function($templateCache, networkService) {
    var l;
    l = function(scope) {
      var submitError;
      scope.submitError = false;
      submitError = function() {
        scope.submitError = true;
        return scope.$apply();
      };
      scope.reset = function() {
        scope.submitError = false;
        return scope.form.reset();
      };
      return scope.submit = function() {
        scope.submitError = false;
        return scope.form.submit(null, submitError);
      };
    };
    return {
      restrict: 'E',
      scope: {
        form: '='
      },
      template: $templateCache.get('coolForm.submit'),
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformText', function($templateCache) {
    var l;
    l = function(scope) {
      scope.value = scope.field.value;
      scope.field.onChange.push(function(v) {
        if (v !== scope.value) {
          return scope.value = v;
        }
      });
      scope.$watch('value', function(v, o) {
        return scope.field.set(v);
      });
      scope.type = "text";
      if (scope.field.options.type != null) {
        return scope.type = scope.field.options.type;
      }
    };
    return {
      restrict: 'E',
      scope: {
        field: '='
      },
      template: $templateCache.get('coolForm.text'),
      link: l
    };
  });

  angular.module('CoolFormDirectives').directive('coolformWizard', function($templateCache) {
    var l;
    l = function(scope) {
      var validatePage;
      scope.current = 0;
      validatePage = function(p) {
        return scope.service.validateFields(pageFields[p]);
      };
      scope.moveTo = function(i) {
        if (i < scope.current) {
          scope.current = i;
        }
        if (scope.form.pages[scope.current].validate() === true) {
          return scope.current = i;
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
        var i, _i, _ref, _ref1;
        if (scope.current + 1 >= scope.form.pages.length) {
          return true;
        }
        for (i = _i = _ref = scope.current + 1, _ref1 = scope.form.pages.length - 1; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; i = _ref <= _ref1 ? ++_i : --_i) {
          if (scope.form.pages[i].display === true) {
            return false;
          }
        }
        return true;
      };
      return scope.nextTitle = function() {
        if (scope.current + 1 < scope.form.pages.length) {
          return scope.form.pages[scope.current + 1].title;
        }
      };
    };
    return {
      restrict: 'E',
      scope: {
        form: '='
      },
      template: $templateCache.get('coolForm.wizard'),
      link: l
    };
  });

  angular.module('CoolFormValidators').factory('emailValidator', function() {
    var validator;
    validator = function(name, fields, options) {
      var p;
      if ((fields[name].value == null) || typeof fields[name].value !== "string") {
        return false;
      }
      p = /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i;
      if (fields[name].value.match(p)) {
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
    validator = function(name, fields, options) {
      if ((fields[name].value == null) || typeof fields[name].value !== "string") {
        return false;
      }
      if (fields[name].value.length === options.size) {
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
    validator = function(name, fields, options) {
      if ((fields[name].value == null) || typeof fields[name].value !== "string") {
        return false;
      }
      if (fields[name].value.length <= options.size) {
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
    validator = function(name, fields, options) {
      if ((fields[name].value == null) || typeof fields[name].value !== "string") {
        return false;
      }
      if (fields[name].value.length >= options.size) {
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
    validator = function(name, fields, options) {
      var v;
      v = fields[name].value;
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

  angular.module('CoolFormValidators').factory('notNullValidator', function() {
    var validator;
    validator = function(name, fields, options) {
      var v;
      v = fields[name].value;
      if (v === void 0 || v === null) {
        return false;
      } else {
        return true;
      }
    };
    return {
      validator: validator,
      init: null
    };
  });

  angular.module('CoolFormValidators').factory('sameAsValidator', function() {
    var init, validator;
    validator = function(name, fields, options) {
      if (fields[name].value === fields[options.field].value) {
        return true;
      } else {
        return false;
      }
    };
    init = function(name, fields, options) {
      if (fields[options.field] != null) {
        fields[options.field].onChange;
      }
      return services.watchField(rule.options.field, null, null, function(value) {
        return services.validateField(name);
      });
    };
    return {
      validator: validator,
      init: init
    };
  });

  angular.module('CoolFormValidators').factory('validators', function(emailValidator, exactSizeValidator, maxSizeValidator, minSizeValidator, notBlankValidator, notNullValidator, sameAsValidator) {
    var add, get, validators;
    validators = {
      email: emailValidator,
      exact_size: exactSizeValidator,
      max_size: maxSizeValidator,
      min_size: minSizeValidator,
      not_blank: notBlankValidator,
      not_null: notNullValidator,
      same_as: sameAsValidator
    };
    get = function(name) {
      if (validators[name] != null) {
        return validators[name];
      }
      return null;
    };
    add = function(dep) {
      return validators[dep.name] = angular.injector([dep.module]).get(dep.factory);
    };
    return {
      get: get,
      add: add
    };
  });

  angular.module('CoolFormServices').factory('coreService', function(validators, directivesService, networkService) {
    return function(definition) {
      var Displayable, Element, Field, Form, Line, Page, Validator, directives, form, _fields;
      directives = directivesService();
      _fields = {};
      Element = (function() {
        function Element(subElemName) {
          this.subElemName = subElemName;
        }

        Element.prototype.isValid = function() {
          var e, _i, _len, _ref;
          _ref = this[this.subElemName];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            e = _ref[_i];
            if (e.isValid() === false) {
              return false;
            }
          }
          return true;
        };

        Element.prototype.reset = function() {
          var e, _i, _len, _ref, _results;
          _ref = this[this.subElemName];
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            e = _ref[_i];
            _results.push(e.reset());
          }
          return _results;
        };

        Element.prototype.validate = function() {
          var e, valid, _i, _len, _ref;
          valid = true;
          _ref = this[this.subElemName];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            e = _ref[_i];
            if (e.display === true && e.validate() === false) {
              valid = false;
            }
          }
          return valid;
        };

        return Element;

      })();
      Displayable = (function(_super) {
        __extends(Displayable, _super);

        Displayable.prototype._doDisplay = function(def, showOrHide) {
          var field, values, _results,
            _this = this;
          _results = [];
          for (field in def) {
            values = def[field];
            _results.push(_fields[field].onChange.push(function(v) {
              var i, _i, _len;
              for (_i = 0, _len = values.length; _i < _len; _i++) {
                i = values[_i];
                if (v === i) {
                  _this.display = showOrHide;
                  return;
                }
              }
              return _this.display = !showOrHide;
            }));
          }
          return _results;
        };

        function Displayable(def, subElemName) {
          Displayable.__super__.constructor.call(this, subElemName);
          this.display = true;
          if (def['show_on'] != null) {
            this._doDisplay(def['show_on'], true);
          }
          if (def['hide_on'] != null) {
            this._doDisplay(def['hide_on'], false);
          }
        }

        return Displayable;

      })(Element);
      Form = (function(_super) {
        __extends(Form, _super);

        function Form(def) {
          var d, p, _i, _len, _ref;
          Form.__super__.constructor.call(this, "pages");
          this.name = def['name'];
          this.action = def['action'];
          this.method = def['method'] == null ? "POST" : def['method'];
          this.submitLabel = def['submit'];
          this.resetLabel = def['reset'];
          this.headers = def['headers'];
          this.hiddens = def['hiddens'];
          this.pages = (function() {
            var _i, _len, _ref, _results;
            _ref = def['pages'];
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              p = _ref[_i];
              _results.push(new Page(p));
            }
            return _results;
          })();
          if (def['dependencies'] != null) {
            _ref = def['dependencies'];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              d = _ref[_i];
              switch (d.type) {
                case 'validator':
                  validators.add(d);
                  break;
                case 'directive':
                  directives.add(d.name, d.tag);
              }
            }
          }
        }

        Form.prototype.submit = function(success, error) {
          var k, params, v, _ref;
          if (!this.validate()) {
            return;
          }
          params = {
            method: this.method,
            action: this.action,
            data: {},
            success: success,
            error: error
          };
          if (this.headers != null) {
            params['headers'] = this.headers;
          }
          if (this.hiddens != null) {
            _ref = this.hiddens;
            for (k in _ref) {
              v = _ref[k];
              params.data[k] = v;
            }
          }
          for (k in _fields) {
            v = _fields[k];
            if (v.display === true) {
              params.data[k] = v.value;
            }
          }
          return networkService().sendForm(params);
        };

        return Form;

      })(Element);
      Page = (function(_super) {
        __extends(Page, _super);

        function Page(def) {
          var l;
          Page.__super__.constructor.call(this, def, "lines");
          this.title = def['title'];
          this.description = def['description'];
          this.lines = (function() {
            var _i, _len, _ref, _results;
            _ref = def['lines'];
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              l = _ref[_i];
              _results.push(new Line(l));
            }
            return _results;
          })();
        }

        return Page;

      })(Displayable);
      Line = (function(_super) {
        __extends(Line, _super);

        function Line(def) {
          var f;
          Line.__super__.constructor.call(this, def, "fields");
          this.fields = (function() {
            var _i, _len, _ref, _results;
            _ref = def['fields'];
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              f = _ref[_i];
              _results.push(new Field(f));
            }
            return _results;
          })();
        }

        return Line;

      })(Displayable);
      Field = (function(_super) {
        __extends(Field, _super);

        function Field(def) {
          var v;
          Field.__super__.constructor.call(this, def);
          this.name = def['name'];
          this.type = def['type'];
          this.label = def['label'];
          this.size = def['size'] != null ? def['size'] != null : 1;
          this.help = def['help'];
          this["default"] = def['default'];
          this.options = def['options'] != null ? def['options'] : {};
          this.value = this["default"];
          if (def['validators'] != null) {
            this.validators = (function() {
              var _i, _len, _ref, _results;
              _ref = def['validators'];
              _results = [];
              for (_i = 0, _len = _ref.length; _i < _len; _i++) {
                v = _ref[_i];
                _results.push(new Validator(v, this.name));
              }
              return _results;
            }).call(this);
          } else {
            this.validators = [];
          }
          this.mandatory = this._isMandatory(def);
          this.error = null;
          this.valid = true;
          this.onChange = [];
          this.onValidate = [];
          _fields[this.name] = this;
        }

        Field.prototype._isMandatory = function(def) {
          if ((def['mandatory'] == null) || !def['mandatory']) {
            return false;
          }
          this.mandatory = true;
          return this.validators.push(new Validator({
            'name': 'not_null'
          }, this.name));
        };

        Field.prototype.isValid = function() {
          return this.valid;
        };

        Field.prototype._doValidate = function(res, msg) {
          var h, _i, _len, _ref;
          _ref = this.onValidate;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            h = _ref[_i];
            h(res);
          }
          this.valid = res;
          this.error = msg;
          return res;
        };

        Field.prototype.set = function(value) {
          var h, _i, _len, _ref;
          if (value === this.value) {
            return;
          }
          this.value = value;
          _ref = this.onChange;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            h = _ref[_i];
            h(this.value);
          }
          return this._doValidate(true);
        };

        Field.prototype.reset = function() {
          this.set(this["default"] ? this["default"] : null);
          return this._doValidate(true);
        };

        Field.prototype.validate = function() {
          var v, _i, _len, _ref;
          _ref = this.validators;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            v = _ref[_i];
            if (v.validate() === false) {
              return this._doValidate(false, v.message);
            }
          }
          return this._doValidate(true);
        };

        Field.prototype.directive = function() {
          return directives.get(this.type);
        };

        return Field;

      })(Displayable);
      Validator = (function() {
        function Validator(def, fieldName) {
          var v;
          this.name = def['name'];
          this.message = def['message'];
          this.options = def['options'];
          this.fieldName = fieldName;
          v = validators.get(this.name);
          if (v === !null && (v.init != null)) {
            v.init(this.fieldName, this.options, _fields);
          }
        }

        Validator.prototype.validate = function() {
          var v;
          v = validators.get(this.name);
          if (v === null) {
            return true;
          }
          return v.validator(this.fieldName, _fields, this.options);
        };

        return Validator;

      })();
      if (definition['form'] != null) {
        form = new Form(definition['form']);
        form.reset();
        return form;
      } else {
        return null;
      }
    };
  });

  angular.module('CoolFormServices').factory('directivesService', function() {
    return function() {
      var add, directives, get;
      directives = {
        text: "coolform-text"
      };
      add = function(type, name) {
        return directives[type] = name;
      };
      get = function(type) {
        return directives[type];
      };
      return {
        get: get,
        add: add
      };
    };
  });

  angular.module('CoolFormServices').factory('networkService', function($q) {
    return function() {
      var getJSON, net, sendForm;
      getJSON = function(url, error) {
        var deferred;
        deferred = $q.defer();
        $.getJSON(url, function(data) {
          return deferred.resolve(data);
        }).fail(error);
        return deferred.promise;
      };
      sendForm = function(params) {
        var cfg;
        cfg = {
          type: params.method,
          url: params.action,
          contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
          data: params.data,
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

  angular.module('CoolFormServices').factory('validationService', function(validators) {
    return function(events) {
      var errors, fields, initValidation, removeError, setError, validateAll, validateField, validateFields, validateForRule;
      errors = {};
      fields = {};
      removeError = function(fieldName) {
        delete errors[fieldName];
        events.handle(fieldName, "ok");
        return true;
      };
      setError = function(fieldName, msg) {
        msg = msg === null ? true : msg;
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
      validateForRule = function(fieldName, rule, values) {
        var msg, vl;
        msg = null;
        vl = validators.get(rule.validator);
        if (!vl || (vl.validator == null)) {
          return true;
        }
        if (vl.validator(fieldName, values, rule) === false) {
          if ((rule.options != null) && (rule.options.message != null)) {
            msg = rule.options.message;
          }
          return setError(fieldName, msg);
        }
        return true;
      };
      validateField = function(fieldName, values) {
        var field, rule, _i, _len, _ref;
        field = fields[fieldName];
        if (field.validation != null) {
          _ref = field.validation;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            rule = _ref[_i];
            if (!validateForRule(fieldName, rule, values)) {
              return false;
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

  angular.module('CoolFormDirectives').run(function($templateCache) {
    $templateCache.put("coolForm.container", "<form><div class=\"container-fluid\"><coolform-wizard ng-if=\"wizard\" form=\"form\"></coolform-wizard><div ng-if=\"page\"><coolform-page page=\"page\" service=\"service\"></coolform-page><coolform-submit form=\"form\"></coolform-submit></div></div></form>");
    $templateCache.put("coolForm.controller", "<div><div ng-if=\"!form\" ng-hide=\"loadingError\" ng-include=\" 'coolForm.loading' \"></div><coolform-error-loading ng-if=\"loadingError\" reload=\"reload\"></coolform-error-loading><div ng-if=\"form\"><coolform-container form=\"form\"></coolform-container></div></div>");
    $templateCache.put("coolForm.error_loading", "<div class=\"alert alert-warning\"><strong>Cannot load the Form!</strong><p>Please check your internet connection and try to: &nbsp;<button type=\"button\" ng-click=\"load()\" class=\"btn btn-primary\">Reload the Form</button></p></div>");
    $templateCache.put("coolForm.error_submit", "<div class=\"alert alert-danger\"><strong>Error : Cannot submit the Form!</strong><p>Please check your internet connection and try again.</p></div>");
    $templateCache.put("coolForm.field", "<div class=\"form-group\" ng-show=\"field.display\" ng-class=\"{'has-error': !field.valid}\"><label class=\"control-label\" for=\"{{ field.name }}\">{{ field.label }}<span ng-if=\"field.mandatory\">&nbsp;*</span></label><div><coolform-dynamic field=\"field\"></coolform-dynamic></div><p class=\"help-block\" ng-bind-html=\"help\"></p></div>");
    $templateCache.put("coolForm.line", "<div class=\"row\" ng-show=\"line.display\"><div ng-repeat=\"field in line.fields\"><div class=\"col-md-{{ field.size * 3 }}\"><coolform-field field=\"field\"></coolform-field></div></div></div>");
    $templateCache.put("coolForm.loading", "<div class=\"alert alert-info\"><strong>Loading form</strong><p>Please wait while loading the form</p></div>");
    $templateCache.put("coolForm.page", "<div ng-if=\"page.title || page.description\" class=\"row\"><div class=\"col-md-12\"><h4 ng-if=\"page.title\" class=\"text-primary\">{{ page.title }}</h4><div ng-if=\"page.description\"><div ng-bind-html=\"page.description\"></div></div></div></div><coolform-line ng-repeat=\"line in page.lines\" line=\"line\"></coolform-line>");
    $templateCache.put("coolForm.submit", "<div class=\"row\" ng-if=\"submitError\"><div class=\"col-md-12\"><div><div ng-include=\" 'coolForm.error_submit' \"></div></div></div></div><div class=\"row\"><div class=\"col-md-12\"><div class=\"well well-sm\"><button ng-click=\"submit()\" type=\"button\" class=\"btn btn-primary\">{{ form.submitLabel }}</button> <button ng-if=\"form.resetLabel\" ng-click=\"reset()\" type=\"button\" class=\"btn btn-default\">{{ form.resetLabel }}</button></div></div></div>");
    $templateCache.put("coolForm.text", "<input type=\"{{ type }}\" class=\"form-control\" placeholder=\"{{ field.placeholder }}\" ng-model=\"value\">");
    return $templateCache.put("coolForm.wizard", "<div class=\"row\"><div class=\"col-md-12\"><ul class=\"nav nav-tabs\"><li ng-repeat=\"page in form.pages\" ng-show=\"page.display\" ng-class=\"{active: isCurrent($index)}\"><a ng-click=\"moveTo($index)\" ng-class=\"{'text-danger': !form.pages[$index].isValid()}\" href=\"\">{{ page.title }}</a></li><li></li></ul></div></div><div ng-repeat=\"page in form.pages\"><coolform-page ng-show=\"isCurrent($index)\" page=\"page\"></coolform-page></div><div ng-hide=\"isLast()\" class=\"row\"><div class=\"col-md-12\"><div class=\"well well-sm\"><button ng-click=\"moveToNext()\" type=\"button\" class=\"btn btn-primary\" ng-class=\"{'btn-danger': !form.pages[current].isValid()}\"><span class=\"glyphicon glyphicon-arrow-right\"></span>{{ nextTitle() }}</button></div></div></div><coolform-submit ng-show=\"isLast()\" form=\"form\"></coolform-submit>");
  });

}).call(this);
