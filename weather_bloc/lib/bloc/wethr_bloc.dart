import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wethr_event.dart';
part 'wethr_state.dart';

class WethrBloc extends Bloc<WethrEvent, WethrState> {
  WethrBloc() : super(WethrInitial()) {
    on<WethrEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
