import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Daily Meals'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: GridView(
          padding: EdgeInsets.all(25),
          // ignore: prefer_const_literals_to_create_immutables
          children: DUMMY_CATEGORIES
              .map((catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  ))
              .toList(),
          // ignore: prefer_const_constructors
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
