import os
from flask import Flask

app = Flask(__name__)

# The secret value will be read from an environment variable
# which is populated by the Kubernetes secret.
API_KEY = os.environ.get("API_KEY", "default-key")

@app.route("/")
def hello():
    return f"Hello! The API key starts with: {API_KEY[:4]}..."

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)