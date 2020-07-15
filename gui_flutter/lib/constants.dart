import 'package:flutter/material.dart';

const double ICON_SIZE = 60;
const double TEXT_SIZE = 24;
const Color ICON_COLOR = Colors.deepPurple;
const URL = 'http://192.168.1.1:9001/cmd';

const String CMD_PLAY = 'keypress Space';
const String CMD_NEXT = 'keypress >';
const String CMD_PREVIOUS = 'keypress <';
const String CMD_SEEK_BACK = 'keypress Left';
const String CMD_SEEK_FWD = 'keypress Right';
const String CMD_VOL_UP = 'keypress 0';
const String CMD_VOL_DOWN = 'keypress 9';
const String CMD_MUTE = 'keypress m';
const String CMD_NEXT_FRAME = 'keypress ,';
const String CMD_PREV_FRAME = 'keypress .';
const String CMD_LOAD_REPLACE = 'loadfile https://youtu.be/example replace';
const String CMD_LOAD_APPEND = 'loadfile https://youtu.be/example append-play';
