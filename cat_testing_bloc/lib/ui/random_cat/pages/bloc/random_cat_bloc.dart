import 'package:bloc/bloc.dart';
import 'package:cat_testing_bloc/ui/random_cat/random_cat.dart';
import 'package:equatable/equatable.dart';

part 'random_cat_event.dart';
part 'random_cat_state.dart';

class RandomCatBloc extends Bloc<RandomCatEvent, RandomCatState> {
  final CatRepository catRepository;
  RandomCatBloc({required this.catRepository}) : super(const RandomCatState()) {
    on<RandomCatEvent>((event, emit) => _mapSearchEventToState(event, emit));
  }

  _mapSearchEventToState(
      RandomCatEvent event, Emitter<RandomCatState> emit) async {
    try {
      emit(state.copyWith(status: RandomCatStatus.loading));
      final cat = await catRepository.search();
      if (cat.breeds == null || cat.breeds!.isEmpty) {
        emit(state.copyWith(status: RandomCatStatus.emptyBreeds));
      } else {
        emit(state.copyWith(cat: cat, status: RandomCatStatus.success));
      }
    } catch (_) {
      emit(state.copyWith(status: RandomCatStatus.failure));
    }
  }
}
