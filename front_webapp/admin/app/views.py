#!/usr/bin/python
# -*- encoding: utf-8 -*-
'''Views'''

from flask import render_template

from app import app


CACHE_TIMEOUT = app.config['CACHE_TIMEOUT']

@app.route('/')
def index():
    '''index page, redirects to login page'''
    return render_template('auth/login.html')
