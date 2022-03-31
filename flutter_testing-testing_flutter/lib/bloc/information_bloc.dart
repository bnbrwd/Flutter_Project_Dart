import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState>
    with Validators {
  InformationBloc() : super(InformationInitial()) {
    on<InformationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  //Stream controller
  final _name = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  //Getters  //sink used for input and stream used for output.

  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get city => _city.stream.transform(cityValidator);

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeCity => _city.sink.add;
}
