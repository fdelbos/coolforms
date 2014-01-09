Coolform Directive
==================

Displaying a form is very easy, just user the `coolform` directive

```
<coolform url="definition.json"></coolform>
```

The directive can take various parameters:

* **url** *(URL)* : The url where download the form definition
* **definition** *(jsobj)* : a javacript object to use as the form definition
* **success** *(callback)* : a callback to trigger on success
* **error** *(callback)* : a callback to be called on validation error
* **failure** *(callback)* : called there is a problem with the connection
* **send** *(jsobj)* : will assign a submit hook to the parameter

