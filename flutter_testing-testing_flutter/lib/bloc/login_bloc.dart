import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/validators.dart';
import 'package:rapido_screen_using_bloc_architecture/data/modal/login.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {

  final Repository repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((loginEvent, emit) async {
      // TODO: implement event handler
      if(loginEvent is LoginEventRequested){
        emit(LoginEventLoading());
        try{
          final LoginResponse loginResponse = await repository.loginRequest(loginEvent.phoneNumber);
          emit(LoginStateSuccess(loginResponse: loginResponse));
        }catch (error){
          print(error);
        }
      }
    });
  }
  //Stream controller
  final _phoneNumber = BehaviorSubject<String>();

  // Getter
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);

  Function(String) get changePhoneNumber => _phoneNumber.sink.add;

  void dispose() {
    _phoneNumber.close();
  }
}
