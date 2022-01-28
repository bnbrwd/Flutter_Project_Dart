import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners(); 
    // let listening which its know that somthing chaanged and they should rebuild.
    //it is equivalent to set state and stateful widget, 
  }
}
