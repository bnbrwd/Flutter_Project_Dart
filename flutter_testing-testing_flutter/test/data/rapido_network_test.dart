import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapido_screen_using_bloc_architecture/data/rapido_network.dart';

class MockHttp extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late NetworkService networkService;
  late MockHttp http;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    http = MockHttp();
    networkService = NetworkService();
  });

  //Checking for Login Flow.
  group('constructor', () {
    test('Given user is checking whether NetworkService class is called.',
        () async {
      expect(NetworkService, isNotNull);
    });
  });

  group("Login Response", () {
    test("""Given user is entering correct credential,
    Api is called successfully,
    but empty response is recieved. """, () async {
      final response = MockResponse();
      final loginData = {
        "countryCode": "91",
        "phone": "7717743329",
      };
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn("");
      when(() => http.post(any())).thenAnswer((_) async => response);

      try {
         networkService.loginRequest(loginData);
      } catch (error) {
        expect(error, isA<ErrorEmptyResponse>);
      }
    });

    test("""When user enter correct Login credential, 
    Api is called successfully,
    Non-empty respose is recieved. """, () async {
      final response = MockResponse();
      final loginData = {
        "countryCode": "91",
        "phone": "7717743329",
      };
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(
          '{"data":{"token":"string"},"status": 0,"message": "string"}');
      when(() => http.post(any())).thenAnswer((_) async => response);

      networkService.loginRequest(loginData);
      final responseData = json.decode(response.body);
      expect(json.decode(response.body), responseData);
    });
  });

  // Checking for Otp flow.
  test("""when user enter the otp verfication credential,
  api is called successfully,
  but get the empty reponse""", () async {
    final otpVerificationData = {"token": "token", "otp": "168975"};
    final response = MockResponse();

    when(() => response.statusCode).thenReturn(200);
    when(() => response.body).thenReturn("");
    when(() => http.post(any())).thenAnswer((_) async => response);
    try {
      networkService.checkAuthorized(otpVerificationData);
    } catch (error) {
      expect(error, isA<ErrorEmptyOtpResponse>);
    }
  });

  test("""when user enter the otp verfication credential,
  api is called successfully,
  but get the non-empty reponse""", () async {
    final otpVerificationData = {"token": "token", "otp": "168975"};
    final response = MockResponse();

    when(() => response.statusCode).thenReturn(200);
    when(() => response.body).thenReturn(
        '{"data":{"accessToken":"string"},"status":0,"message": "string"}');
    when(() => http.post(any())).thenAnswer((_) async => response);

     networkService.checkAuthorized(otpVerificationData);
    final responseData = json.decode(response.body);
    expect(json.decode(response.body), responseData);
  });
}
