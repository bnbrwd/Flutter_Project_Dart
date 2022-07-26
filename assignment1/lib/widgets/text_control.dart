// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class TextControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextControlState();
  }
}

class _TextControlState extends State<TextControl> {

  String _mainText = 'Welcome to Flutter';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(_mainText),
          ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orange),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Text('Change Text'),
            onPressed: () {
              setState(() {
                _mainText = 'Changed';
              });
            },
          ),
      ],),
    );
  }
}