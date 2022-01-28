import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//converting data

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Pizza',
      description: 'extra cheese Pizza .',
      price: 89.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/07/19/16/04/pizza-6478478_1280.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Watch',
      description: 'a wall Watch .',
      price: 99.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/12/19/10/42/old-6880626_1280.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Mug',
      description: 'a small Mug .',
      price: 20.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2022/01/06/23/43/coffee-6920499_1280.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Apple',
      description: 'fruits Apple',
      price: 80.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/10/25/14/45/apples-6741164_1280.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Peanuts',
      description: 'delicious Peanuts',
      price: 50.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2022/01/06/11/30/peanuts-6919261_1280.jpg',
    ),
    Product(
      id: 'p10',
      title: 'Burger',
      description: 'delicious Hamburger',
      price: 60.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2020/10/05/19/55/hamburger-5630646_1280.jpg',
    ),
    Product(
      id: 'p11',
      title: 'ColdDrink',
      description: 'delicious ColdDrink',
      price: 30.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2021/10/24/14/40/drink-6738301_1280.jpg',
    ),
    Product(
      id: 'p12',
      title: 'Biscuits',
      description: 'delicious Biscuits',
      price: 10.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2022/01/12/09/29/ladyfinger-6932354_1280.jpg',
    ),
  ];

  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  // }

  void addProduct(Product product) {
    const url =
        'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products.json';
    // collection will create as named products
    http.post(
      Uri.parse(url) ,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
      }),
    );
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); //at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('........');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
