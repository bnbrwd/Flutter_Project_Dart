import 'package:dictionary_app_test/model/word_response.dart';
import 'package:dictionary_app_test/repo/word_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late WordRepository wordRepository;
  setUp(() {
    wordRepository = WordRepository();
  });

  group('Dictionary Repository testing \n', () {
    test('When instantiates Repository', () {
      expect(wordRepository, isNotNull);
    });

    test('When user enter word  getWordsFromDictionary should called once.',
        () async {
      const word = 'cat';
      try {
        await wordRepository.getWordsFromDictionary(word);
      } catch (_) {
        verify(() => wordRepository.getWordsFromDictionary(word)).called(1);
      }
    });

    test('When user enter word api is call sucessfully', () async {
      const word = 'cat';
      try {
        final response = await wordRepository.getWordsFromDictionary(word);
        expect(response, isA<List<WordResponse>>());
      } catch (_) {
        verify(() => wordRepository.getWordsFromDictionary(word)).called(1);
      }
    });
  });
}

