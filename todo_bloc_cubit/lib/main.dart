import 'package:flutter/material.dart';
import 'package:todo_bloc_cubit/presentation/router.dart';

void main() {
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;
  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
