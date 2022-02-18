import 'package:authentication_bloc_rxdart/bloc/login_bloc.dart';
import 'package:authentication_bloc_rxdart/bloc/register_bloc.dart';
import 'package:authentication_bloc_rxdart/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
