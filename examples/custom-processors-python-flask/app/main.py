import re
from flask import Flask, request

app = Flask(__name__)

@app.route('/preprocess', methods=['POST'])
def preprocess():
    data = request.get_json()

    for keyId, key in enumerate(data['collection']['keys']):
        for transId, trans in enumerate(key['translations']):
            data['collection']['keys'][keyId]['translations'][transId]['translation'] = re.sub('BANNED', '', trans['translation'])

    return data, 200


@app.route('/postprocess', methods=['POST'])
def postprocess():
    data = request.get_json()

    for keyId, key in enumerate(data['collection']['keys']):
        for transId, trans in enumerate(key['translations']):
            data['collection']['keys'][keyId]['translations'][transId]['translation'] = re.sub('BANNED', '', trans['translation'])

    return data, 200