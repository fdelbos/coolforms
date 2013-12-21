# Form Definition

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

### page
Your form should have at least one `page`, if there are more it will be displayed as a wizard.

* **title** *(String)* : A title for the page
* **description** *(String)* : A description to be displayed on top of the page. Can be in HTML format.
* **lines** *([[line](#line), …])* A list of lines.

### line


