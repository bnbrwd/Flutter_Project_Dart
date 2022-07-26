part of 'dictionary_bloc.dart';

@immutable
abstract class DictionaryEvent {}

class DictionaryEventRequested extends DictionaryEvent {
  final String word;

  DictionaryEventRequested({required this.word});

  List<Object> get props => [word];
}
