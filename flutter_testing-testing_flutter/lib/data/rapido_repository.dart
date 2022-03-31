import 'package:rapido_screen_using_bloc_architecture/data/modal/login.dart';
import 'package:rapido_screen_using_bloc_architecture/data/modal/otp.dart';
import 'package:rapido_screen_using_bloc_architecture/data/rapido_network.dart';

class Repository {
  
  final NetworkService networkService;

  Repository({
    required this.networkService,
  });
  Future<LoginResponse> loginRequest(String phoneNumber) async {
    final loginData = {"countryCode": "91", "phone": phoneNumber};
    final response = await networkService.loginRequest(loginData);
    print("printing the response in repository layer $response");
    return LoginResponse.fromJson(response);
  }

  Future<OtpResponse> checkAuthorized(String enterdOtp, String token)async {
    final otpVerificationData = {"token": token, "otp":enterdOtp};
    final response = await networkService.checkAuthorized(otpVerificationData);
    return OtpResponse.fromJson(response);
  }
}
