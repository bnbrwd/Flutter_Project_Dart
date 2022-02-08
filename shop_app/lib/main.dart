import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/screens/splash_screen.dart';
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
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (ctx) => Products(),
        // ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
          // now Auth() can be listen in anywhere in application.
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          // here we are getting token that are available in Auth and <Auth, Products> means data taking from first 
          //and transferring into second. also it depends on Auth so Auth must defined above this.
          //also when Auth update then also product rebuild. here Product depends on Auth.
          create: (ctx) => Products('', [], ''),
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              previousProducts == null ? [] : previousProducts.items,
              auth.userId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
          // now Cart() can be listen in anywhere in application.
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => Orders(),
        //   // now Orders() can be listen in anywhere in application.
        // ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', [], ''),
          update: (ctx, auth, previousOrders) => Orders(auth.token,
              previousOrders == null ? [] : previousOrders.orders, auth.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato',
          ),
          // home: ProductsOverviewScreen(),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          debugShowCheckedModeBanner: false,
          routes: {
            ProductDetailScreen.routeName: (ctx) =>
                ProductDetailScreen(), //registered
            CartScreen.routeName: (ctx) => CartScreen(), //registered
            OrdersScreen.routeName: (ctx) => OrdersScreen(), //registered
            UserProductsScreen.routeName: (ctx) =>
                UserProductsScreen(), //registered
            EditProductScreen.routeName: (ctx) =>
                EditProductScreen(), //registered
          },
        ),
      ),
    );
  }
}
