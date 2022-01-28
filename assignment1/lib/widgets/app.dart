import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assignment1'),
        ),
        body: Center(
          child: Container(
            child: const Text('My First Assignment'),
          ),
        ),
      );
  }
}