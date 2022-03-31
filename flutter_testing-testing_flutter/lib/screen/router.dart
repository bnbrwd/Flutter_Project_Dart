import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/information_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/login_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/otp_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/constant/strings.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_network.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_repository.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/information_screen.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/login_screen.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/otp_screen.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/splash_screen.dart';

class AppRouter {
  late Repository repository;
  late LoginBloc loginBloc;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    loginBloc = LoginBloc(repository: repository);
  }

  MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (builder) => SplashScreen());
      case LOGIN_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: loginBloc,
                  child: LoginScreen(),
                ));
      case OTP_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (builder) => BlocProvider(
            create: (context) => OtpBloc(repository: repository),
            child: const OtpScreen(),
          ),
        );
      case INFORMATION_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (builder) => BlocProvider(
                  create: (context) => InformationBloc(),
                  child: InformationScreen(),
                ));
    }
  }
}
