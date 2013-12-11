## 
## Makefile
## 
## Created by Frederic DELBOS - fred.delbos@gmail.com on Nov 30 2013.
## 

NAME	= app
SRC 	= app.coffee
TMP     = __

all: build

build:
	coffee --join $(TMP).coffee --compile $(SRC)
	mv $(TMP).js $(NAME).js

min:
	uglifyjs $(NAME).js -o $(NAME).min.js

lint:
	coffeelint $(SRC)

watch:
	coffee -wj $(NAME).coffee -c $(SRC)

clean:
	rm -fr $(NAME).js $(NAME).min.js $(TMP).coffee $(TMP).js

deps:
	npm install -g coffee-script uglify-js coffeelint

