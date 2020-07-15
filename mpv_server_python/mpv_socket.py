import socket
import subprocess
import time

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
socket_addr = '/tmp/mpvsocket'


def start_mpv():
    subprocess.run(["killall", "mpv"])
    subprocess.run(["rm", socket_addr])

    start_cmd = ["mpv",
                 "--idle",
                 "--input-ipc-server=/tmp/mpvsocket",
                 "--loop",
                 "--quiet",
                 "--force-window",
                 "--mute",
                 ]

    with open("mpv_log.txt", "w") as mpv_log:
        subprocess.Popen(start_cmd, stdout=mpv_log, stderr=mpv_log)
    time.sleep(1)
    s.connect(socket_addr)


def send(cmd):
    cmd = bytearray(cmd + "\n", encoding="UTF-8")
    s.send(cmd)


def read():
    data, _, _, _ = s.recvmsg(1024)
    return data.decode()


start_mpv()
