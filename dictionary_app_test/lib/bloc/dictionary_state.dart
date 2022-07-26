part of 'dictionary_bloc.dart';

@immutable
abstract class DictionaryState {}

class DictionaryInitial extends DictionaryState {}

class NoWordDictionary extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
  final List<WordResponse> words;

  DictionaryLoaded(this.words);
}

class DictionaryError extends DictionaryState {
  final message;

  DictionaryError(this.message);
}
