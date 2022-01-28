import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdapativeFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdapativeFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoButton(
            child: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            onPressed: handler,
          )
        : TextButton(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(primary: Colors.purple),
            onPressed: handler,
          );
  }
}
