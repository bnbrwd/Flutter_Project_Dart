import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_mode_project/bloc/app_theme_bloc.dart';
import 'package:theme_mode_project/view/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppThemeBloc>(
      create: (context) => AppThemeBloc(),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: ((context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            home: const ThemeHomePage(),
          );
        }),
      ),
    );
  }
}
