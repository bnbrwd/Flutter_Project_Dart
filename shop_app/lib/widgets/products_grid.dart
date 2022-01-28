import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length, //no of elements displayed
      itemBuilder: (ctx, i) => MultiProvider(
        providers: [
          // ChangeNotifierProvider(   // it is less preffered
          //   create: (c) => products[i],
          // ),
          ChangeNotifierProvider.value(  // it is more prefereed when we have to reused..
            value: products[i],
          ),
        ],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ), // see on screen it will do how every grid item is build.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //amount of column.
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10, //space b\w columns
        mainAxisSpacing: 10, //space b\w rows
      ), // how grid should be structured.eg how many column should have.
    );
  }
}
