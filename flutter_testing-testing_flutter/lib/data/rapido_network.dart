import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  Future loginRequest(Map<String, String> loginData) async {
    const url = "http://staging-api.rapido.bid/api/v1/login";

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "phone": loginData["phone"],
          "countryCode": loginData["countryCode"]
        }));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        return responseData;
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorLoginRequsetResponse();
    }
  }

  Future checkAuthorized(Map<String, String> otpVerificationData) async {
    const url = "http://staging-api.rapido.bid/api/v1/verify";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "token": otpVerificationData["token"],
          "otp": otpVerificationData["otp"],
        },
      ),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        return responseData;
      } else {
        throw ErrorEmptyOtpResponse();
      }
    } else {
      throw ErrorOtpRequestResponse();
    }
  }
}

class ErrorLoginRequsetResponse implements Exception {}

class ErrorEmptyResponse implements Exception {}

class ErrorOtpRequestResponse implements Exception {}

class ErrorEmptyOtpResponse implements Exception {}
