import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Playlist extends StatefulWidget{
  Playlist({Key key, this.title}) : super(key:key);

  final String title;

  @override
  State<StatefulWidget> createState() => _PlaylistState();

}


class _PlaylistState extends State<Playlist> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }

}