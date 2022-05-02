import os
import base64
from dotenv import load_dotenv
load_dotenv()

import zipfile
import io
import requests
import lokalise

from flask import Flask, render_template, request, redirect, url_for, session

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

@app.route('/login')
def login():
    login_url = __auth_client().auth(
        ["read_projects", "read_files", "write_files"], "http://localhost:5000/callback", "random state"
    )
    return render_template('login.html', login_url=login_url)

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('token', None)
    session.pop('project_id', None)
    return redirect(url_for('login'))
    
@app.route('/callback')
def callback():
    code = request.args.get('code', '')
    response = __auth_client().token(code)
    session['token'] = response['access_token']
    return redirect(url_for('login'))

@app.route('/projects', methods=['GET', 'POST'])
def projects():
    if request.method == 'POST':
        session['project_id'] = request.form['project_id']
        return redirect(url_for('login'))
    else:
        projects = __oauth_client().projects().items
        return render_template('projects.html', projects=projects)


@app.route('/download', methods=['GET', 'POST'])
def download():
    if request.method == 'POST':
        #client = lokalise.Client(os.getenv('LOKALISE_API_KEY'))
           # client.download_files(os.getenv('LOKALISE_PROJECT_ID'), {
        response = __oauth_client().download_files(session['project_id'], {
            "format": "json",
            "filter_langs": ["en"],
            "original_filenames": True,
            "directory_prefix": ""
        })
        
        data = io.BytesIO(requests.get(response['bundle_url']).content)
        
        with zipfile.ZipFile(data) as archive:
            archive.extract("en.json", path="i18n/")
        
        return redirect(url_for('download'))
    else:
        return render_template('download.html')

@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        #client = lokalise.Client(os.getenv('LOKALISE_API_KEY'))
        filename = os.path.join(os.path.dirname(__file__), 'i18n/en.json')
        with open(filename) as f:
            content = f.read()
            # client.upload_file(os.getenv('LOKALISE_PROJECT_ID'), {
            __oauth_client().upload_file(session['project_id'], {
                "data": base64.b64encode(content.encode()).decode(),
                "filename": 'en.json',
                "lang_iso": 'en'
            })
        return redirect(url_for('upload'))
    else:
        return render_template('upload.html')


def __auth_client():
    return lokalise.Auth(os.getenv('OAUTH2_CLIENT_ID'), os.getenv('OAUTH2_CLIENT_SECRET'))
    
def __client():
    return lokalise.Client(os.getenv('LOKALISE_API_KEY'))
    
def __oauth_client():
    return lokalise.OAuthClient(session['token'])