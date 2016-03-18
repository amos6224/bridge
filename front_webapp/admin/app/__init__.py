from flask import Flask, render_template, jsonify

app = Flask(__name__)

from werkzeug.contrib.cache import SimpleCache

app.config.from_object('config')
cache = SimpleCache(default_timeout=app.config['CACHE_TIMEOUT'])


# Sample HTTP error handling
@app.errorhandler(404)
def not_found(error):
    '''Error handling'''
    return render_template('404.html'), 404

@app.route('/help', methods = ['GET'])
def help():
    """Print available functions."""
    if app.debug:
        print(app.view_functions.keys())
        func_list = {}
        for rule in app.url_map.iter_rules():
            if rule.endpoint != 'static':
                func_list[rule.rule] = app.view_functions[rule.endpoint].__doc__
        return jsonify(func_list)
    else:
        return render_template('404.html'), 404

# Import a module / component using its blueprint handler variable
from app.mod_auth.controllers import mod_auth as auth_module

# Register blueprint(s)
app.register_blueprint(auth_module)

from app import views
