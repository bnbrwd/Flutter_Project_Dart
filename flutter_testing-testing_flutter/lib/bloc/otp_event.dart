part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}
class Authorized extends OtpEvent{
  final String enteredOtp;
  final String token;
  Authorized({required this.enteredOtp, required this.token});

}