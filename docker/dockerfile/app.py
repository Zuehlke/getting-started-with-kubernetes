from flask import Flask, jsonify, request
import os,sys

app = Flask(__name__)

@app.route('/')
def hello_messages():
    # return helpers.hellomessages.hello_english()
    output = "Hello World!"
    if 'ECS_CONTAINER_METADATA_URI' in os.environ:
        output = os.environ['ECS_CONTAINER_METADATA_URI']
    return output


@app.route('/not_found')
def not_found():
    return jsonify(message='not found.'), 404


@app.route('/<random_string>')
def return_backwards_string(random_string):
    """Reverse and return the provided URI"""
    return "".join(reversed(random_string))

@app.route('/shutdown')
def shutdown():
    sys.exit()
    os.exit(0)
    return

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888)
