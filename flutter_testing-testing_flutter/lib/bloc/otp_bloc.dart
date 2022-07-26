import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapido_screen_using_bloc_architecture/data/modal/otp.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final Repository repository;
  OtpBloc({required this.repository}) : super(OtpInitial()) {
    on<OtpEvent>((otpEvent, emit) async {
      if (otpEvent is Authorized) {
        emit(OtpLoading());
        try {
          final response = await repository.checkAuthorized(
              otpEvent.enteredOtp, otpEvent.token);
          emit(OtpStateSucess(otpResponse: response));
        } catch (error) {
          print(error);
        }
      }
    });
  }
}
