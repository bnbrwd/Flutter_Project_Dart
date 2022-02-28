// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  //ChangeNotifier is a mixin that allow to call notifyListener which then used by the
  //provider package to update all places where you listen to that provided object thereafter.

  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
    // return copy of items or get access copy of _items
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    //so that everyone listening, will get informed about that changed data will get new data.
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    //read the table.
    final dataList = await DBHelper.getData('user_places');
    //convert list of map into list
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              image: File(item['image']),
              location: null,
              title: item['title'],
            ))
        .toList();
    notifyListeners();
  }
}
