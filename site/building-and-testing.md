# Building and Testing

### Dependencies and Compilation

1. Before all you should have [node js](http://nodejs.org/) and npm installed.

2. The project is build and tested via [GruntJS](http://gruntjs.com/)
   ```
   npm install -g grunt-cli
   ```

3. Clone the project locally:
   
   ```
   git clone https://github.com/fdelbos/coolforms.git
   ```

4. Go to the project directory: 
   
   ```
   cd coolforms
   ```

5. Install node dependencies: 

   ```
   npm install
   ```

6. Once everything is installed you can simply run grunt to build the js file and it's minified version.

   ```
   grunt
   ```

### Testing
If you want to develop your own features or participate to the project, you most likely want to run the unit tests. To do so run:
 
```
grunt test
```

on the command line, it will start [karma](http://karma-runner.github.io/0.8/plus/AngularJS.html). Karma is configured for Chrome by default but you can add your favorite browser by adding it to `karma.conf.coffe` in the entry `browsers` for example if you want to test in  firefox as well, write :

```
browsers: ['Chrome', 'Firefox']
```

Also a test server is available with a demo page for convenience, you can start server with `grunt server` and go to [http://localhost:8000/demo/](http://localhost:8000/demo/) to view it. Note that in this mode Grunt will watch the files in `src` and rebuild `coolform.js` if it detect a change. Finaly `grunt test` and `grunt server` are not exclusives, you can run them simultaneously.
