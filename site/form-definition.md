# Form Definition

With CoolForms, forms are displayed automatically from a definition. This allows you to create them on the fly and avoir cluttering your code with HMTL. In this document you will learn how to create them from scratch.

Also know that a python library exists : [py-coolforms](http://fdelbos.github.io/py-coolforms/) allowing you to generate a JSON definition on the fly.

### A JSON hireachy model

Form definitions are orginized in a hireachical fashion: A Form contains pages that contains lines that contains fields… for an example to get you started see: [simple.json](static/simple.json)

You can provide the form to `coolform` the directive directly from a js object or from an URL that `coolform` will download and display automatically. For more information on that matter see: [coolform-directive](coolform-directive)


