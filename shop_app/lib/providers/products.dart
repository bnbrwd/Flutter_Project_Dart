import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//converting data

class Products with ChangeNotifier {
  List<Product> _items = [
    /*  Product(
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
    ), */
  ];

  final String authToken;
  //final is run time constant.
  final String userId;
  Products(this.authToken, this._items, this.userId);

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

  //read
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(Uri.parse(url));
      print('getResult ${json.decode(response.body)}');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData == null){
        return;
      }
       url =
        'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          // isFavorite: prodData['isFavorite'],
          isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
          //here afte ?? is default value could be assigned.
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //create
  Future<void> addProduct(Product product) async {
    // by putting async all addProduct will wrap into future
    final url =
        'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    // collection will create as named products now no need to return just remove return
    // await tells to wait for this operation to finish before we move into next line.
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
          // 'isFavorite': product.isFavorite,
        }),
        //then runs after response comes.
      );
    } catch (error) {
      print(error);
      throw error;
    }

    print('result: ${response.headers}');
    print('result in json: ${json.decode(response.body)}');
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: json.decode(response.body)['name'],
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); //at the start of the list
    notifyListeners();
  }
  //below for store in memory
  // final newProduct = Product(
  //   title: product.title,
  //   description: product.description,
  //   price: product.price,
  //   imageUrl: product.imageUrl,
  //   id: DateTime.now().toString(),
  // );
  // _items.add(newProduct);
  // // _items.insert(0, newProduct); //at the start of the list
  // notifyListeners();

  //Update
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      //patch request will tell to firebase to merge the data which is incomming with the existing data
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('........');
    }
  }

  //delete
  Future<void> deleteProduct(String id) async {
    final url =
        'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var exitingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, exitingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    exitingProduct = null; // if success

    //final means run time constant
    // final url =
    //     'https://shopapp-flutter-c6be4-default-rtdb.firebaseio.com/products/$id.json';
    //     http.delete(Uri.parse(url));
    // _items.removeWhere((prod) => prod.id == id);
    // notifyListeners();
    //update all places in athe app that would care.
  }
}
