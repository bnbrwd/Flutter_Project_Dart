import 'package:flutter/material.dart';
import './screens/user_products_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
          // now Cart() can be listen in anywhere in application.
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
          // now Orders() can be listen in anywhere in application.
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) =>
              ProductDetailScreen(), //registered
          CartScreen.routeName: (ctx) => CartScreen(), //registered
          OrdersScreen.routeName: (ctx) => OrdersScreen(), //registered
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(), //registered
          EditProductScreen.routeName: (ctx) => EditProductScreen(), //registered
        },
      ),
    );
  }
}
