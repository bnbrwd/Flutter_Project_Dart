import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

//Show list of products.
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  //async means always return future
  Future<Void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
    //it will call but we don't really want to listen to update and products
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    print('rebuilding');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount:
                              productData.items.length, // no of items in list.
                          itemBuilder: (_, i) => Column(
                            children: <Widget>[
                              UserProductItem(
                                productData.items[i].id,
                                productData.items[i].title,
                                productData.items[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
