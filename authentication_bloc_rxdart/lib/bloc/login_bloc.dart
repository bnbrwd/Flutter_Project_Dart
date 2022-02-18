import 'dart:async';

import 'package:authentication_bloc_rxdart/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // here maxin extends by "with"

  //Stream controller
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getters  //sink used for input and stream used for output.

  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);

  //RxDart can combine all stream and check validation at a time.
  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (a, b) => true);
  //here two parameter so we have used latest2

  //Setters  //sink used for input and stream used for output.

  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  void submit() {
    //Api  can call from here.
    print('Login email = ${_loginEmail.value}');
  }

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}
