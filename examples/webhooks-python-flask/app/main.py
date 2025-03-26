import os
import lokalise

from dotenv import load_dotenv
load_dotenv()

from flask import Flask, render_template, request, redirect, url_for, flash
 
app = Flask(__name__, template_folder='../templates')
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'
 

@app.route("/")
def home():
    return render_template('home.html')


@app.route('/webhooks', methods=['POST'])
def webhooks():
    __client().create_webhook(request.form['project_id'], {
        "url": os.getenv('NOTIFY_URL'),
        "events": ["project.key.added"]
    })
    flash(f"Successfully registered webhook for {request.form['project_id']} project ID")
    return redirect(url_for('home'))


@app.route('/notify', methods=['POST'])
def notify():
    data = request.get_json()
    if data != ['ping'] and data['event'] == 'project.key.added':
        __client().create_key_comments(data['project']['id'], data['key']['id'], [
            {
                "comment": "@Bob please double check this newly added key!"
            }
        ])

        __client().update_key(data['project']['id'], data['key']['id'], {
            "is_hidden": True
        })
      
    if data['event'] == 'project.translations.updated':
      print(f"Project name: {data['project']['name']}")
      print(f"User name: {data['user']['full_name']}")

      for translation in data['translations']:
          print(f"Translation ID: {translation['id']}")
          print(f"Translation value: {translation['value']}")
          print(f"Language: {translation['language']['name']}")
          print(f"Key: {translation['key']['name']}")
          
    return "", 200


def __client():
    return lokalise.Client(os.getenv('LOKALISE_API_KEY'))
