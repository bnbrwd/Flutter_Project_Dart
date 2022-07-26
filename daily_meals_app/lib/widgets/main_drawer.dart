import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTitle(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          // fontFamily:
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            // color: Theme.of(context).primaryColorLight,
            color: Colors.amber,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                // color: Theme.of(context).primaryColor,
                color: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle('Meals', Icons.restaurant, () {
            // Navigator.of(context).pushNamed('/');
            Navigator.of(context).pushReplacementNamed(
                '/'); //it will replace the extisting page on the stack
          }),
          buildListTitle('Filters', Icons.settings, () {
            // Navigator.of(context).pushNamed(FiltersScreen.routeName);
            Navigator.of(context).pushReplacementNamed(FiltersScreen
                .routeName); //it will replace the extisting page on the stack
          }),
        ],
      ),
    );
  }
}
