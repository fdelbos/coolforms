## 
## core.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 13 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

angular.module('CoolFormServices').
  factory('coreService', (validators, directivesService)->

    return(definition) ->

      directives = directivesService()
      _fields = {}                  

      class Element
        constructor: (subElemName) ->
          @subElemName = subElemName
          @valid = true

        reset: -> e.reset() for e in this[@subElemName]

        validate: ->
          for e in this[@subElemName]
            if e.display is true and e.validate() is false
              @valid = false; return @valid              
          @valid = true; return @valid

      class Displayable extends Element
        _doDisplay: (def, showOrHide) ->
          for field, values of def
            _fields[field].onChange.push (v) =>
              for i in values
                if v == i
                  @display = showOrHide
                  return
              @display = !showOrHide

        constructor: (def, subElemName) ->
          super(subElemName)
          @display = true
          if def['show_on']? then this._doDisplay(def['show_on'], true)
          if def['hide_on']? then this._doDisplay(def['hide_on'], false)


      class Form extends Element
        constructor: (def) ->
          super("pages")
          @name = def['name']
          @action = def['action']
          @method = if !def['method']? then "POST" else def['method']
          @submitLabel = def['submit']
          @resetLabel = def['reset']
          @pages = (new Page(p) for p in def['pages'])
          if def['dependencies']? then switch d for d in def['dependencies']
            when 'validator' then validators.add(d)
            when 'field' then dump 'field'

        submit: -> this.validate()
        

      class Page extends Displayable
        constructor: (def) ->
          super(def, "lines")
          @title = def['title']
          @description = def['description']
          @lines = (new Line(l) for l in def['lines'])


      class Line extends Displayable
        constructor: (def) ->
          super(def, "fields")
          @fields = (new Field(f) for f in def['fields'])


      class Field extends Displayable
        constructor: (def) ->
          super(def)
          @name = def['name']
          @type = def['type']
          @label = def['label']
          @size = if def['size']? then def['size']? else 1
          @help = def['help']
          @default = def['default']
          @options = if def['options']? then def['options'] else {}
          @value = @default
          if def['validators']?
            @validators = (new Validator(v, @name) for v in def['validators'])
          else @validators = []
          @error = null
          @onChange = []
          @onValidate = []
          _fields[@name] = this

        _doValidate: (res, msg) ->
          (h(res) for h in @onValidate)
          @valid = res
          @error = msg
          return res    

        set: (value) ->
          if value == @value then return
          @value = value
          (h(@value) for h in @onChange)
          this._doValidate(true)
          
        reset: ->
          this.set(if @default then @default else null)
          this._doValidate(true)

        validate: ->
          for v in @validators
            if v.validate() is false
              return this._doValidate(false, v.message)
          this._doValidate(true)

        directive: -> directives.get(@type)

      class Validator
        constructor: (def, fieldName) ->
          @name = def['name']
          @message = def['message']
          @options = def['options']
          @fieldName = fieldName
          v = validators.get(@name)
          if v is not null and v.init?
            v.init(@fieldName, @options, _fields)

        validate: ->
          v = validators.get(@name)
          if v is null then return true
          return v.validator(@fieldName, _fields, @options)

      if definition['form']?
        form = new Form(definition['form'])
        form.reset()
        return form
      else
        return null
  )
