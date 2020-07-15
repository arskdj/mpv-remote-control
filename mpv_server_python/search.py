from subprocess import Popen, PIPE
import utils
import json

def youtube(query):
    n_results = 20
    search_param = "ytsearch{}: {}".format(n_results, query)
    cmd = ["youtube-dl", search_param, "--dump-json"]
    with open(utils.get_filename(query), "w") as f:
        Popen(cmd, stdout=f)


def torrents(query):
    cmd = ["python3", "$HOME/.local/share/data/qBittorrent/nova3/nova2.py", "all", "all", query]
    keys = ["torrent", "title", "bytes", "seeders", "leechers", "search", "url"]
    sep="|"
    p = Popen(cmd, stdout=PIPE)
    with open(utils.get_filename(query), "w") as f:
        while utils.is_running(p):
            line = p.stdout.readline().decode("utf-8")
            if sep not in line:
                continue
            line = line.split(sep)
            line = str(dict(zip(keys, line)))
            j = json.dumps(line)
            f.write(j)
            f.write("\n")


search = {
    "youtube": youtube,
    "torrents":torrents,
}


def run(query, engine):
    if not utils.file_exists(utils.get_filename(query)):
        search[engine](query)
