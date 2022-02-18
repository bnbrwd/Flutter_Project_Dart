import 'package:authentication_bloc_rxdart/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  //Stream controller
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  //Getters  //sink used for input and stream used for output.

  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(phoneValidator);
  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(passwordValidator);

  //RxDart can combine all stream and check validation at a time.
  Stream<bool> get isValid => Rx.combineLatest5(name, email, phoneNumber,
      password, confirmPassword, (a, b, c, d, e) => true);
  //here five parameter so we have used latest5

  //RxDart can combine all stream and check validation at a time.
  Stream<bool> get isPasswordMatch =>
      Rx.combineLatest2(password, confirmPassword, (a, b) {
        if (a != b) {
          return false;
        } else {
          return true;
        }
      });
  //here two parameter so we have used latest2

  //Setters  //sink used for input and stream used for output.

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  void submit() {
    if (password != confirmPassword) {
      _confirmPassword.sink.add('Password doedn\'t match');
    } else {
      print('REGISTER');
      // register api call
    }
  }

  void dispose() {
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
}
