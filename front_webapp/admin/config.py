import os
from datetime import timedelta


ENVS = os.environ
BASEDIR = os.path.abspath(os.path.dirname(__file__))
UPLOAD_FOLDER = os.path.join(BASEDIR, 'tmp')
ALLOWED_EXTENSIONS = set(['csv', 'xls', 'xlsx'])
FILEPATH = ''
GOOGLE_ID = ENVS.get('IMPORT_GOOGLE_ID')
GOOGLE_SECRET = ENVS.get('IMPORT_GOOGLE_SECRET')
SECRET_KEY = ENVS.get('IMPORT_SECRET_KEY')
PERMANENT_SESSION_LIFETIME = timedelta(seconds=15*60)
CACHE_TIMEOUT = 15*60
SESSION_COOKIE_NAME = 'asdasdd1dftbg4f2qesf2r12er1rfgh3bweg3f1'
# Application threads. A common general assumption is
# using 2 per available processor cores - to handle
# incoming requests using one and performing background
# operations using the other.
THREADS_PER_PAGE = 2
# Enable protection agains *Cross-site Request Forgery (CSRF)*
CSRF_ENABLED = True
NAMELY_ID = ENVS.get('IMPORT_NAMELY_ID')
NAMELY_SECRET = ENVS.get('IMPORT_NAMELY_SECRET')
