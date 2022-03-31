import 'package:bloc/bloc.dart';
import 'package:dictionary_app_test/model/word_response.dart';
import 'package:dictionary_app_test/repo/word_repo.dart';
import 'package:meta/meta.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final WordRepository repository;

  DictionaryBloc(this.repository) : super(DictionaryInitial()) {
    on<DictionaryEvent>((event, emit) async {
      if (event is DictionaryEventRequested) {
        emit(DictionaryLoading());
        try {
          final words = await repository.getWordsFromDictionary(event.word);
          if (words == null) {
            emit(DictionaryError("There is some issue"));
          } else {
            print(words.toString());
            emit(DictionaryLoaded(words));
            emit(NoWordDictionary());
          }
        } on Exception catch (e) {
          print(e);
          emit(DictionaryError(e.toString()));
        }
      }
    });
  }
}
