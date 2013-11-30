#! /usr/bin/env python
# 
# mk.py
# 
# Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 22 2013.
# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.
# 

import subprocess, argparse, sys, time, os
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

templates = [
    'container',
    'controller',
    'field',
    'header',
    'line',
    'page',
    'submit',
    'text',
    'wizard',
]

sources = [
    'src/coffee/templates.coffee',
    'src/coffee/init.coffee',
    'src/coffee/directives/*.coffee',
    'src/coffee/validators/*.coffee',
    'src/coffee/services/*.coffee']

outname = 'coolforms'
templates_file = '## generated file do not edit\n\ntemplates =\n%s\n'
templates_path = 'src/coffee/templates.coffee'

def callsh(cmd):
    print cmd
    return True if subprocess.call(cmd, shell=True) == 0 else False

def make_templates():
    gen = ""
    for name in templates:
        fd = open(os.path.join('./src/html/', name + '.html'), 'r')
        content = fd.read()
        fd.close()
        gen += "  %s: \"\"\"%s\"\"\"\n" % (name, content)
    fd = open(templates_path, 'w')
    fd.write(templates_file % gen)
    fd.close()
    return templates

def build():
    make_templates()    
    return callsh('coffee -j %s.coffee -c %s'  % (outname, " ".join(sources)))

def minify():
    return callsh('uglifyjs %s.js -o %s.min.js' % (outname, outname))

def clean():
    return callsh('rm -fr %s.coffe %s.js %s.min.js' % (outname, outname, outname))

class FileChangeHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if event.src_path.split('/')[-1][0] == '.':
            return
        print "change detected at: %s" % event.src_path
        if build() is False:
            print "build failed!"

def watch_files():
    build()
    event_handler = FileChangeHandler()
    observer = Observer()
    observer.schedule(event_handler, "./src", recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == "__main__":    

    parser = argparse.ArgumentParser()
    parser.add_argument("action", help="can be: 'build', 'watch', 'clean', or 'min'")
    args = parser.parse_args()
    action = args.action

    

    if action == "build":
        if build() is False:
            print "build failed!"
            sys.exit(1)

    elif action == "watch":
        watch_files()

    elif action == "clean":
        clean()

    elif action == "min":
        if build() is False or minify() is False:
            print "build failed!"
            sys.exit(1)

    else:
        print "Unknow command!"
        sys.exit(1)
