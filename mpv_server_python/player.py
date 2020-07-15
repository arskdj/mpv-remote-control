import threading
import time
import mpv_socket as mpv
import json

state = {}

commands = {
    "pause": 'keypress Space',
    "loopFile": 'keypress L',
    "abLoop": 'keypress l',
    "next": "keypress >",
    "previous": "keypress <",
    "seekBack": "keypress Left",
    "seekFwd": "keypress Right",
    "volUp": 'keypress 0',
    "volDown": "keypress 9",
    "mute": "keypress m",
    "nextFrame": "keypress .",
    "prevFrame": "keypress ,",
    # "setVol": '{ "command": ["set_property", "volume", %s] }',
}

load_commands = {
    "load": 'loadfile {} replace',
    "loadAppend": 'loadfile {} append',
}

properties = [
    "volume",
    "pause",
    "duration",
    "media-title",
    "mute",
]

periodic_properties = [
    "time-pos"
]


def command(cmd_key):
    cmd_key = cmd_key
    if cmd_key not in commands.keys():
        return "command not found"
    cmd = commands[cmd_key]
    mpv.send(cmd)
    return cmd


def load(cmd_key, url):
    if cmd_key not in load_commands.keys():
        return "load command not found"
    cmd = load_commands[cmd_key].format(url)
    mpv.send(cmd)
    return cmd


def update_state():
    while True:
        data = mpv.read()
        lines = data.splitlines()
        lines = map(json.loads, lines)
        for line in lines:
            parse_value(line)


def parse_value(row):
    if "data" not in row.keys():
        return

    if "request_id" in row.keys():
        state[periodic_properties[row["request_id"]]] = row["data"]
        return

    if "name" in row.keys():
        state[row["name"]] = row["data"]


def get_time_pos():
    while True:
        for i,pp in enumerate(periodic_properties):
            mpv.send('{ "command": ["get_property", "%s"], "request_id": %d }' % (pp, i))
        time.sleep(1.0)


def init():
    for i, prop in enumerate(properties):
        mpv.send('{ "command": ["observe_property", %d, "%s"] }' % (i, prop))
    threading.Thread(target=update_state, daemon=True).start()
    threading.Thread(target=get_time_pos, daemon=True).start()


init()
