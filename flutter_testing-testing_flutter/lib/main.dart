import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/login_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/otp_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_network.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_repository.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/router.dart';
import './screen/router.dart';

void main() {
  final Repository repository = Repository(networkService: NetworkService());
  runApp(MyApp(
    router: AppRouter(),
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  final Repository repository;
  const MyApp({Key? key, required this.router, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(repository: repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
