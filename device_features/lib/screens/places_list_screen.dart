// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          }),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
