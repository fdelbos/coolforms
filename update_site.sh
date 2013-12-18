#!/bin/sh

grunt && grunt doc
git checkout gh-pages
mv doc/*.html .
mv docs/static .
rm -fr docs
git add *.html static
git commit -m "updating site"
git push origin gh-pages 
git checkout master
