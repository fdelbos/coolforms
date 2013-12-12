coolforms
=========

Coolforms is a form generation library for Angularjs, enabling the develloper to dynamically genreate sophisticated forms. Forms are defined through a JSON definitions file, that could be fetched from a web service or provided as a Javascript object.

Features
--------

* Form rendering from a JSON service or a Javascript object
* Form validation with a set of built-in validators, as well as user defined validators
* Builtin fields and the possibility to add your own set of fields
* Wizard or simple page rendrering
* Posting data directly to a server
* Fully costomizable templates based on Bootstrap
* Conditionnal display of fields
* Custom POST headers (ex: for Cross Site Request Forgery protection)


How to use
----------

1.  Add the following dependencies to your html page
    * [angularjs](https://ajax.googleapis.com/ajax/libs/angularjs/1.2.3/angular.js)
    * [angularjs-sanitize](https://ajax.googleapis.com/ajax/libs/angularjs/1.2.3/angular-sanitize.js)
    * [jQuery](https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js)
    * and optionnaly the [bootstrap css file](https://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css)


2.  Download [coolforms.js](https://raw.github.com/fdelbos/coolforms/master/coolforms.js)  or the minified version [coolforms.min.js](https://raw.github.com/fdelbos/coolforms/master/coolforms.min.js) 

3.  Create form definition file or a service that render JSON, for example:
<pre>
{
    "form": {
        "name": "demo",
        "action": "/some_url",
        "method": "POST",
        "submit": "Submit my CoolForm!",
        "reset": "Reset Button",
        "pages": [
            {
                "title": "CoolForms Example",
                "description": "A simple form demonstrating an example CoolForm.",
                "lines": [
                    {
                        "fields": [
                            {
                                "name": "first_name",
                                "type": "text",
                                "label": "First Name",
                                "size": 1
                            },
                            {
                                "name": "last_name",
                                "type": "text",
                                "label": "Last Name",
                                "size": 1
                            },
                            {
                                "name": "email",
                                "type": "text",
                                "label": "Email",
                                "size": 1,
                                "validation": [
                                    {
                                        "validator": "email",
                                        "options": {
                                            "message": "This is not a valid email!"
                                        }
                                    }
                                ]
                            },
                            {
                                "name": "password",
                                "type": "text",
                                "label": "Password",
                                "size": 1,
                                "help": "At least 6 characters",
                                "validation": [
                                    {
                                        "validator": "not_blank",
                                        "options": {
                                            "message": "Too short!"
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    }
}

</pre>
4.  Create an [AngularJS Application](http://docs.angularjs.org/api/ng.directive:ngApp) and add the dependency `CoolForm` for example:
    * add to your js: `angular.module('app', ['CoolForm'])`
    * change your HTML to: `<body ng-app="app">`
5. Add a coolform direcite somewhere. For example: `<coolform url="definition.json"></coolform>`

Your setup is complete and you should see something like this:

![intro_form1](https://raw.github.com/fdelbos/coolforms/master/ressources/intro_form1.png)

If you click the submit button you will see that validation works:

![intro_form2](https://raw.github.com/fdelbos/coolforms/master/ressources/intro_form2.png)
