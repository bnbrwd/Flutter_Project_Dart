import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => GreatPlaces(),
          // now GreatPlaces() can be listen in anywhere in application.
        ),
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: PlacesListScreen(),
        // home: CachedImageScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(), //registered
        },
      ),
    );
  }
}

