import 'package:flutter/material.dart';
import 'package:mpv_remote_control/constants.dart';
import 'package:mpv_remote_control/controller.dart';
import 'package:mpv_remote_control/playlist.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "MPV Controller",
        theme: ThemeData(
          primarySwatch: ICON_COLOR,
          scaffoldBackgroundColor: Colors.grey,
        ),
        home:MpvController(),
        routes: <String, WidgetBuilder> {
          '/playlist': (BuildContext context) => Playlist(title: 'Playlist'),
        });
  }
}