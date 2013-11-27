#! /usr/bin/env python
# 
# run.py
# 
# Created by Frederic DELBOS <fred.delbos@gmail.com> on Nov 22 2013.
# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.
# 

import subprocess, argparse, sys, time, os, httplib, urllib
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

template_files = [
    'container',
    'controller',
    'email',
    'header',
    'line',
    'password',
    'text',
]

coffee_files = [
    'directives/container',
    'directives/controller',
    'directives/email',
    'directives/header',
    'directives/line',
    'directives/password',
    'directives/text',
    'validation/service',
]

outname = "coolforms"

def make_templates():
    templates = "templates =\n"
    for name in template_files:
        fd = open(os.path.join('./src/html/', name + '.html'), 'r')
        content = fd.read()
        fd.close()
        templates += "  %s: \"\"\"%s\"\"\"\n" % (name, content)
    return templates

def make_coffees():
    coffees = ""
    for name in coffee_files:
        fd = open(os.path.join('./src/coffee/',  name + '.coffee'), 'r')
        content = fd.read()
        fd.close()
        coffees += "%s\n" % content
    return coffees

def make_build():
    print "building %s.js" % outname
    content = "## generated file do not edit\n\n%s\n%s" % (make_templates(), make_coffees())
    fd = open('%s.coffee' % outname, 'w')
    fd.write(content)
    fd.close()
    return True if subprocess.call(['coffee', '--compile', '%s.coffee' % outname]) == 0 else False

class FileChangeHandler(FileSystemEventHandler):
    def on_any_event(self, event):
        if event.src_path.split('/')[-1][0] == '.':
            return
        print "change detected at: %s" % event.src_path
        if make_build() is False:
            print "build failed!"

def watch_files():
    make_build()
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

def minify():
    fd = open('%s.js' % outname, 'r')
    js = fd.read()
    fd.close()    
    params = urllib.urlencode([
        ('js_code', js),
        ('compilation_level', 'WHITESPACE_ONLY'),
        ('output_format', 'text'),
        ('output_info', 'compiled_code'),
    ])
    headers = {"Content-type": "application/x-www-form-urlencoded"}
    conn = httplib.HTTPConnection('closure-compiler.appspot.com')
    conn.request('POST', '/compile', params, headers)
    response = conn.getresponse()
    data = response.read()
    fd = open('%s.min.js' % outname, 'w')
    fd.write(data)
    fd.close()
    conn.close()

if __name__ == "__main__":    

    parser = argparse.ArgumentParser()
    parser.add_argument("action", help="can be: 'build', 'watch', or 'minify'")
    args = parser.parse_args()
    action = args.action

    if action == "build":
        if make_build() is False:
            print "build failed!"
            sys.exit(1)

    elif action == "watch":
        print "watching for file change"
        watch_files()

    elif action == "minify":
        print "minifying"
        if make_build() == False:
            print "build failed!"
            sys.exit(1)
        print("sending request to google closure")
        minify()
        print("done generating %s.min.js" % outname)

    else:
        print "Unknow command!"
        sys.exit(1)
