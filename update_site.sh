#!/bin/sh

grunt && grunt doc && git checkout gh-pages && \
rm -fr static && rm -fr *.html && \
mv doc/*.html . && mv doc/static . && rm -fr doc && \
git add *.html static && git commit -m "updating site" && \
git push origin gh-pages  && git checkout master
