import 'package:cat_testing_bloc/catapp_theme.dart';
import 'package:cat_testing_bloc/ui/home/home.dart';
import 'package:cat_testing_bloc/ui/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = CatAppTheme.dark();
    return MaterialApp(
      title: 'Cats',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
