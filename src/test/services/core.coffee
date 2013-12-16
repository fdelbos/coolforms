## 
## core.coffee
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Dec 13 2013.
## This file is subject to the terms and conditions defined in
## file 'LICENSE.txt', which is part of this source code package.
## 

describe 'core tests', ->

  beforeEach(module('CoolFormServices'))

  js1 = """
{"form": {"name": "form", "submit": null, "method": "POST", "resest": null, "action": "/truc", "pages": [{"lines": [{"fields": [{"help": "some help", "name": "f1", "validators": [], "label": "a text field", "type": "text", "size": 1}, {"help": "some help", "show_on": {"f1": ["toto", "titi"]}, "name": "f2", "validators": [], "label": "a text field", "type": "text", "size": 1}]}, {"fields": [{"help": null, "name": "email", "validators": [{"message": "invalid email", "name": "email", "options": {}}], "label": "an email field", "type": "text", "size": 1}], "hide_on": {"f2": ["show"]}}], "description": "this is my first page", "title": "First Page"}]}}"""                  

  d1 = jQuery.parseJSON(js1)

  it 'should build hierarchy', inject((coreService) ->
    hierarchy = coreService(d1)
    expect(hierarchy).not.toEqual(null)
  )

  it 'should display fields coditionnaly', inject((coreService) ->
    hierarchy = coreService(d1)
    f1 = null
    f2 = null
    email = null
    for p in hierarchy.pages
      for l in p.lines
        for f in l.fields
          if f.name == "f1" then f1 = f
          if f.name == "f2" then f2 = f
    f1.set("dont show")
    expect(f2.display).toEqual false
    f1.set("toto")
    expect(f2.display).toEqual true
    f1.set("something")
    expect(f2.display).toEqual false
    f1.set("titi")
    expect(f2.display).toEqual true
  )

  it 'should validate', inject((coreService) ->
    hierarchy = coreService(d1)
    f1 = null
    f2 = null
    email = null
    for p in hierarchy.pages
      for l in p.lines
        for f in l.fields
          if f.name == "f1" then f1 = f
          if f.name == "f2" then f2 = f
          if f.name == "email" then email = f
    expect(hierarchy.validate()).toEqual false
    expect(email.error).toEqual "invalid email" 
    email.set("fred@mail.com")
    expect(hierarchy.validate()).toEqual true
  )
  
  js2 = """
{"form": {"name": "form", "submit": null, "method": "POST", "resest": null, "action": "/truc", "pages": [{"lines": [{"fields": [{"help": null, "default": "default", "name": "f1", "validators": [], "label": null, "type": "text", "size": 1}, {"help": null, "default": null, "name": "f2", "validators": [{"message": "different!", "name": "same_as", "options": {"field": "f1"}}], "label": null, "type": "text", "size": 1}]}, {"fields": [{"help": null, "default": null, "name": "email", "validators": [{"message": "invalid email", "name": "email", "options": {}}], "label": "an email field", "type": "text", "size": 1}], "hide_on": {"f2": ["show"]}}], "description": "this is my first page", "title": "First Page"}]}}"""

  d2 = jQuery.parseJSON(js2)

  it 'should have default value and validate same_as', inject((coreService) ->
    hierarchy = coreService(d2)
    f1 = null
    f2 = null
    email = null
    for p in hierarchy.pages
      for l in p.lines
        for f in l.fields
          if f.name == "f1" then f1 = f
          if f.name == "f2" then f2 = f
          if f.name == "email" then email = f
    expect(f1.value).toEqual "default"
    expect(f2.validate()).toEqual false
    f1.set("myval")
    expect(f2.validate()).toEqual false
    f2.set("truc")
    expect(f2.validate()).toEqual false
    expect(hierarchy.validate()).toEqual false
    f2.set("myval")
    expect(f2.validate()).toEqual true
    expect(hierarchy.validate()).toEqual false
    f2.set("show")
    f1.set("show")
    expect(hierarchy.validate()).toEqual true
    f2.set("truc")
    f1.set("truc")
    expect(hierarchy.validate()).toEqual false
    email.set("fred@mail.com")
    expect(hierarchy.validate()).toEqual true
  )

