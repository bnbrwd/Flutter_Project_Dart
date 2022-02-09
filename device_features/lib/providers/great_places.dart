import 'package:flutter/foundation.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  //ChangeNotifier is a mixin that allow to call notifyListener which then used by the 
  //provider package to update all places where you listen to that provided object thereafter.

  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
    // return copy of items or get access copy of _items
  }

}