from functools import wraps
from flask import (
        redirect, url_for, session, 
        request, flash, Blueprint
)
from flask_oauthlib.client import OAuth
from app import app

oauth = OAuth(app)

google = oauth.remote_app(
    'google',
    consumer_key=app.config.get('GOOGLE_ID'),
    consumer_secret=app.config.get('GOOGLE_SECRET'),
    request_token_params={
        'scope': 'https://www.googleapis.com/auth/userinfo.email'
    },
    base_url='https://www.googleapis.com/oauth2/v1/',
    request_token_url=None,
    access_token_method='POST',
    access_token_url='https://accounts.google.com/o/oauth2/token',
    authorize_url='https://accounts.google.com/o/oauth2/auth',
)

# Define the blueprint: 'auth', set its url prefix: app.url/auth
mod_auth = Blueprint('auth', __name__, url_prefix='/auth')

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'google_token' not in session or not\
        google.get('userinfo').data['email'].endswith('@namely.com'):
            flash('Please log in')
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function

@mod_auth.route('/login', methods=['GET', 'POST'])
def login():
    '''Starts login'''
    session.clear()
    return google.authorize(callback=url_for('auth.authorized', _external=True))

@mod_auth.route('/logout')
def logout():
    '''Logs out the user'''
    session.pop('google_token', None)
    session.clear()
    return redirect(url_for('index'))

@mod_auth.route('/login/authorized')
@google.authorized_handler
def authorized(resp):
    '''checks if user is an authorized user'''
    if resp is None:
        return 'Access denied: reason=%s error=%s' % (
            request.args['error_reason'],
            request.args['error_description']
        )
    session['google_token'] = (resp['access_token'], '')
    print('USER AUTH: %s' % google.get('userinfo').data.get('email'))
    return redirect(url_for('upload.upload_file'))

@google.tokengetter
def get_google_oauth_token():
    return session.get('google_token')
