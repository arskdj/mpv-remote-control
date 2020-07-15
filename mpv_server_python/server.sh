#!/bin/bash
rm /tmp/mpvsocket
killall mpv
mpv --mute --idle  --input-ipc-server=/tmp/mpvsocket --loop ~/Downloads/mps/Rick\ Astley\ -\ Together\ Forever\ \(Official\ Music\ Video\).mp4&
echo Starting mpv
while [ !  -e /tmp/mpvsocket ]; do
    sleep 0.5
done 

echo Starting server
export FLASK_APP=app.py
#export FLASK_ENV=development
venv/bin/flask run
. venv/bin/activate
ls *.py  | entr -scr  "flask run"
