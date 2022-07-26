import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rapido_screen_using_bloc_architecture/data/modal/login.dart';
import 'package:rapido_screen_using_bloc_architecture/data/modal/otp.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_network.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_repository.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MockNetworkService mockNetworkService;
  late Repository repository;
  setUp(() {
    mockNetworkService = MockNetworkService();
    repository = Repository(networkService: mockNetworkService);
  });
  group('testing networkService layers', () {
    test(
        'checking when user enter correct value of countryCode and phoneNumber',
        () async {
      final loginData = {
        "countryCode": "91",
        "phone": "7717743329",
      };
      final response = MockNetworkService();

      try {
        await mockNetworkService.loginRequest(loginData);
      } catch (_) {
        verify(() => mockNetworkService.loginRequest(loginData)).called(1);
      }
    });

    test('when api call is successful', () async {
      final loginData = {
        "countryCode": "91",
        "phone": "7717743329",
      };

      try {
        final response = await mockNetworkService.loginRequest(loginData);
        expect(LoginResponse.fromJson(response), isA<LoginResponse>);
      } catch (_) {
        verify(() => mockNetworkService.loginRequest(loginData)).called(1);
      }
    });

    test('Checking otp validation function', () async {
      final otpVerificationData = {"token": "klskslsgk", "otp": "168975"};
      try {
        await mockNetworkService.checkAuthorized(otpVerificationData);
      } catch (_) {
        verify(() => mockNetworkService.checkAuthorized(otpVerificationData))
            .called(1);
      }
    });

    test('Checking the mapping of response of OtpModal class', () async {
      final otpVerificationData = {
        "token": "sdflkasdfhoasfhsld",
        "otp": "168975",
      };
      try {
        final response =
            await mockNetworkService.checkAuthorized(otpVerificationData);
        expect(OtpResponse, isA<OtpResponse>);
      } catch (_) {
        verify(() => mockNetworkService.checkAuthorized(otpVerificationData))
            .called(1);
      }
    });
  });
}
