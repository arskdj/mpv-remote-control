from flask import Flask, escape
from werkzeug.utils import redirect
import player
import search
import utils


app = Flask(__name__)


@app.route("/")
def index():
    return player.state


@app.route("/player/<cmd_key>")
def command(cmd_key):
    cmd_key = escape(cmd_key)
    return player.command(cmd_key)


@app.route("/player/<cmd_key>/<path:url>")
def load(cmd_key, url):
    cmd_key = escape(cmd_key)
    url = escape(url)
    return player.load(cmd_key, url)


@app.route("/search/<string:query>")
def search_youtube(query):
    query = escape(query)
    search.run(query, "youtube")
    return redirect("/result/"+query)


@app.route("/result/<string:query>")
def get_result(query):
    query = escape(query)
    return utils.get_results(query)

