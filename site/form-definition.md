Form Definition
===============

With CoolForms, forms are displayed automatically from a definition. This allows you to create them on the fly and avoir cluttering your code with HMTL. In this document you will learn how to create them from scratch.

Also know that a python library exists : [py-coolforms](http://fdelbos.github.io/py-coolforms/) allowing you to generate a JSON definition on the fly.

### A JSON hireachy model

Form definitions are orginized in a hireachical fashion: A Form contains pages that contains lines that contains fields… for an example to get you started see: [simple.json](static/simple.json)

You can provide the form to `coolform` the directive directly from a js object or from an URL that `coolform` will download and display automatically. For more information on that matter see: [coolform-directive](coolform-directive)

### form
`form` is the root element of your definition, it can contain the following keys:

* **action** *(URL)* : The url where the form will be sent
* **name** *(String)* : A name for the form
* **method** *(HTTP-METHOD)* : The http method to use to send the form (GET, POST…)
* **submit** *(String)* : Label for submit button
* **reset** *(String)* : Label for reset button
* **pages** *([[page](#page), …])* : The form pages
* **hiddens** *({"name":"value"})* : A map of hidden fields to be sent along with the form
* **headers** *({"name":"value"})* : A map of request headers to be sent when the form is submitted to the server
* **dependencies** *([[dependency](#dependency), …])* : User defined dependencies.

### page
Your form should have at least one `page`, if there are more it will be displayed as a wizard.

* **title** *(String)* : A title for the page
* **description** *(String)* : A description to be displayed on top of the page. Can be in HTML format.
* **lines** *([[line](#line), …])* A list of lines.

### line
* **lines** *([[field](#field), …])* A list of field. If you are using the default template, there should be no more than 4.

### field
* **name** *(String)* : Name of the field
* **type** *(field type)* : The type of the field. See [Fields](#) for more informations.
* **label** *(String)* : A label to be display along the field. Can contain HTML.
* **size** *(Int)* : Size of the field. With the default template, this should be between 1 and 4.
* **help** *(String)* : An help message to be displayed along the field.
* **mandatory** *(Boolean)* : If false, it will override validators and validate even if the field is blank. If it's not blank then other validators will apply.
* **default** *(Value)* : Default value for this field
* **options** *({"opt":"value"})* : A map of options specific to this type of field. See [Fields](#) for more informations.
* **validators** *([[validator](#validator), …])* : A list of validators to be applied to this field.

### validator
Validators apply validation contraints on fields. See [Validators](#) for a list of builtin validators.

* **name** *(String)* : Name of the validator
* **message** *(String)* : Message to display when the validation failed
* **options** *({"opt":"value"})* : A map of options specific to this validator. See [Validators](#) for more informations.

### dependency
A user can extends coolforms with custom validators and directives.

* **type** *"validator"* : User can define it's own validators, and even override builtin validators. Once declared it can be used like any regular validator. 
* **type** *"directive"* : User can define it's own directives, and even override builtin directives. Once declared it can be used like any regular directive.
* **name** *(String)* : Name used later in the configuration for this dependency.
* **tag** *(String)* : If the dependency is a directive, you have to provide the tag name used to display it. For example: "my-input" will be converted to something like `<my-input field="field"></my-input>`.
* **module** *(Angular Module name)* : the module name of the dependency. Only requiered for validators.
* **factory** *(Angular Factory name)* : the factory name of the dependency. Only requiered for validators.