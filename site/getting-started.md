# Getting Started


### Dependencies

Cool Forms depends on the following librairies, add them to your html file:

* [AngularJs](https://ajax.googleapis.com/ajax/libs/angularjs/1.2.3/angular.js)
* [AngularJs-Sanitize](https://ajax.googleapis.com/ajax/libs/angularjs/1.2.3/angular-sanitize.js)
* [jQuery](https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js)
* and optionally the [Bootstrap css File](https://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css)
* And finally [CoolForms.js](https://github.com/fdelbos/coolforms/releases) itself

### Form Definition

In order for the form to display something it need's a definition. It can be either an url to a 
JSON file or a javascript object. See the 
[simple.json](static/simple.json) sample as an example.

Also the [Form Definition page](form-Definition.html) get deeper on the subject.

### AngularJS Application

The form need to live inside an [angularjs application](http://docs.angularjs.org/api/ng.directive:ngApp),
a very basic way to do it :

Change your HTML body tag to (just like any regular angularjs application):
	   
```
<body ng-app="app">
```

Declare the app in your js like any other angularjs app but with `CoolForm` as a dependency, for example :
   
```
angular.module('app', ['CoolForm']);
```

### Displaying the form

The final step is to display our form. Add a coolform directive somewhere inside your app. For example:

```
<coolform url="definition.json"></coolform>
```
if you get the definition through a URL.

```
<coolform definition="myDefinitionModel"></coolform>
```

if it's a in your angular scope 

### Enjoy!


<div ng-app="app">
<coolform url="static/simple.json"></coolform>
</div>
<script>
angular.module('app', ['CoolForm']);
</script>


### Where to go from there?

Well you are probably curious to know more about definitions so jump to the [Form Definition page](https://github.com/fdelbos/coolforms/wiki/Form-Definition) where you will learn a great deal about it.

Also you may want to build the project yourself: [Building and Testing](building-and-testing.html).
