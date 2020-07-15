import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpv_remote_control/constants.dart';


class MpvController extends StatefulWidget {
    MpvController({Key key, this.title}) : super(key:key);

    final String title;

    @override
    _MpvControllerState createState() => _MpvControllerState();
}

class _MpvControllerState extends State<MpvController>{

  bool _isPaused = true;
  bool _isMuted = false;

  Widget createButton(String text, Icon icon, Function onPressed) {
    return GridTile(child:Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            child: IconButton(
                icon: icon,
                iconSize: ICON_SIZE,
                color: ICON_COLOR,
                onPressed: onPressed,
            ),
        ),
        Center(child:Text(text,
        style: TextStyle(fontSize: TEXT_SIZE),
        )),
    ]));
  }

  Widget getBody(){
    return Padding(
      child:GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          createButton("Load file",   Icon(Icons.insert_emoticon),    () => _sendCommandRequest(CMD_LOAD_REPLACE)),
          createButton("Append file",   Icon(Icons.insert_emoticon),  () => _sendCommandRequest(CMD_LOAD_APPEND)),
          createButton(_isPaused? "Play" : "Pause", _getPlayStateIcon(), _pressPlayButton),
          createButton(_isMuted? "Unmute" : "Mute", _getMuteStateIcon(), _pressMuteButton),
          createButton("Previous",     Icon(Icons.skip_previous),     () => _sendCommandRequest(CMD_PREVIOUS)),
          createButton("Next",         Icon(Icons.skip_next),         () => _sendCommandRequest(CMD_NEXT)),
          createButton("Volume Down",  Icon(Icons.volume_down),       () => _sendCommandRequest(CMD_VOL_DOWN)),
          createButton("Volume Up",    Icon(Icons.volume_up),         () => _sendCommandRequest(CMD_VOL_UP)),
          createButton("Seek back",    Icon(Icons.fast_rewind),       () => _sendCommandRequest(CMD_SEEK_BACK)),
          createButton("Seek forward", Icon(Icons.fast_forward),      () => _sendCommandRequest(CMD_SEEK_FWD)),
          createButton("Prev Frame",   Icon(Icons.exposure_neg_1),    () => _sendCommandRequest(CMD_PREV_FRAME)),
          createButton("Next Frame",   Icon(Icons.exposure_plus_1),   () => _sendCommandRequest(CMD_NEXT_FRAME)),
        ],), padding: EdgeInsets.all(20.0),);
  }

  Future<int> _sendCommandRequest (String command)async{

    try {
      var response = await http.post(URL, body: command);
      print('Sending: $command');
      print('Response status: ${response.statusCode}');
      return response.statusCode;
    } catch (e){
      print(e.toString());
    }

    return -1;
  }

  Icon _getPlayStateIcon(){
    return Icon(_isPaused? Icons.play_arrow : Icons.pause);
  }

  Icon _getMuteStateIcon(){
    return Icon(_isMuted? Icons.volume_off : Icons.volume_mute);
  }

  void _pressPlayButton() async{
    setState(() {
      _isPaused = !_isPaused;
    });

    await _sendCommandRequest(CMD_PLAY);
  }

  void _pressMuteButton() async{
    setState(() {
      _isMuted = !_isMuted;
    });

    await _sendCommandRequest(CMD_MUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controller"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: () {
                Navigator.pushNamed(context, '/playlist');
              }
          )
        ],
      ),
      body: getBody(),
    );
  }
}