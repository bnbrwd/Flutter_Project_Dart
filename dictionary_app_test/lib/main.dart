import 'package:dictionary_app_test/bloc/dictionary_bloc.dart';
import 'package:dictionary_app_test/cubit/dictionary_cubit.dart';
import 'package:dictionary_app_test/repo/word_repo.dart';
import 'package:dictionary_app_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => DictionaryCubit(WordRepository()),
        // create: (context) => DictionaryBloc(WordRepository()),
        child: HomeScreen(),
      ),
    );
  }
}
