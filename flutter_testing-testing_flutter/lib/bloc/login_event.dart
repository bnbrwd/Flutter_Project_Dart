part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginEventRequested extends LoginEvent{
  final String phoneNumber;
  LoginEventRequested({required this.phoneNumber});
  @override
  List<Object> get props =>[phoneNumber];
}
