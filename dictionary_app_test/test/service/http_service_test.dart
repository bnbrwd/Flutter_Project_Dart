import 'package:dictionary_app_test/model/result_error.dart';
import 'package:dictionary_app_test/service/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttp httpClient;

  const query = 'cat';

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockHttp();
  });

  group('Dictionary Service Testing \n', () {
    test('constructor', () {
      expect(HttpService(), isNotNull);
    });

    group('When Dictionary Search\n', () {
      test(
          'make correct http request with empty response,'
          ' throw [ErrorEmptyResponse]', () async {
        final response = MockResponse();

        when((() => response.statusCode)).thenReturn(200);
        when((() => response.body)).thenReturn('');
        when((() => httpClient.get(any()))).thenAnswer((_) async => response);
        try {
          await HttpService.getRequest("en_US/$query");
          fail('should throw error empty body');
        } catch (error) {
          expect(error, isA<Exception>());
        }
        verifyNever(() => httpClient.get(Uri.parse(
                "https://api.dictionaryapi.dev/api/v2/entries/en_US/cat")))
            .called(0);
      });

      test('When ResultError on non-200 response', () async {
        final response = MockResponse();
        when((() => response.statusCode)).thenReturn(404);
        when((() => httpClient.get(any()))).thenAnswer((_) async => response);

        HttpService.getRequest("en_US/$query").then((value) {
          expect(value, throwsA(isA<ErrorSearchingDict>()));
        });
      });

      test('When Search get valid response', () async {
        final response = MockResponse();
        when((() => response.statusCode)).thenReturn(200);
        when((() => response.body)).thenReturn(
            '{"data":{"accessToken":"string"},"status":0,"message": "string"}');
        when((() => httpClient.get(any()))).thenAnswer((_) async => response);

        HttpService.getRequest("en_US/$query").then((value) {
          expect(jsonDecode(value.body), jsonDecode(response.body));
        });
      });

      // test('When Search get valid response', () async {
      //   final response = MockResponse();
      //   when((() => response.statusCode)).thenReturn(200);
      //   when((() => response.body)).thenReturn(
      //       '{"data":{"accessToken":"string"},"status":0,"message": "string"}');
      //   when((() => httpClient.get(any()))).thenAnswer((_) async => response);

      //   await HttpService.getRequest("en_US/$query");

      //   expect(WordResponse.fromJson(jsonDecode(response.body)),
      //       isA<WordResponse>());
      // });
    });
  });
}
