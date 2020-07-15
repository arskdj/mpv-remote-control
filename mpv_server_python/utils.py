from os.path import join
import hashlib
import constants
import json
from pathlib import Path


def get_filename(query):
    q_hash = hashlib.sha3_256(bytearray(query, encoding="UTF-8")).hexdigest()
    filename = join(constants.RESULT_DIR, q_hash)
    return filename


def get_results(query):
    filename = get_filename(query)
    with open(filename, "r") as f:
        return dict(enumerate(map(json.loads, f.readlines())))


def is_running(p):
    p.poll()
    return p.returncode is None


def file_exists(filename):
    file = Path(filename)
    return file.is_file()
