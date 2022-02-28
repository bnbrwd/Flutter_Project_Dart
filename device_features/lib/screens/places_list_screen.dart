// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                //here we can come back to previous screen so we used pushNamed not pushReplacement.
              }),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: Text('Got no places yet, start adding some!'),
        ),
        //here ch will return above child text.
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[i].image),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {
                    //go to detail page  ......
                  },
                ),
              ),
      ),
    );
  }
}
