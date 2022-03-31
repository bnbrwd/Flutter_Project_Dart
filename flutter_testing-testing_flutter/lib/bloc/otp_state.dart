part of 'otp_bloc.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpStateSucess extends OtpState {
  final OtpResponse otpResponse;

  OtpStateSucess({required this.otpResponse});
   @override 

  List<Object> get props => [otpResponse];
}

class OtpLoading extends OtpState {}
