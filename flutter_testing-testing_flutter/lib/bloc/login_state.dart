part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginEventLoading extends LoginState{}
class LoginStateSuccess extends LoginState{
  final LoginResponse loginResponse;

  LoginStateSuccess({required this.loginResponse});
}