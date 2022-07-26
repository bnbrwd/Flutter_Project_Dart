// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
      //To check whether there is local authentication available on this device or not, call canCheckBiometrics:
    } on PlatformException catch (e) {
      print('error: $e');
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
      //To get a list of enrolled biometrics, call getAvailableBiometrics:
    } on PlatformException catch (e) {
      print('error: $e');
      return <BiometricType>[];
    }
  }

  //for android
  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    print('checkBioMetrics-- $isAvailable');
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print('error: $e');
      return false;
    }
  }

  //for ios
  static Future<bool> authenticateiOS() async {
    final isAvailable = await hasBiometrics();
    print('checkBioMetrics-- $isAvailable');
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        iOSAuthStrings: IOSAuthMessages(
          goToSettingsDescription: 'Face ID Required',
        ),
        localizedReason: 'Scan Face to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print('error: $e');
      return false;
    }
  }
}
