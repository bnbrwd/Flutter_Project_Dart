// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mpin_biometric/api/local_auth_api.dart';
import 'package:flutter_mpin_biometric/ui/screens/demo_passcode.dart';
import 'package:flutter_mpin_biometric/ui/screens/home_page.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication page')),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildAvailability(context),
            SizedBox(height: 24),
            buildAuthenticate(context),
            SizedBox(height: 24),
            buildAuthPasscode(context),
          ],
        )),
      ),
    );
  }

  Widget buildAvailability(BuildContext context) {
    return buildButton(
      text: 'Check Availability',
      icon: Icons.event_available,
      onClicked: () async {
        final isAvailable = await LocalAuthApi.hasBiometrics();
        final biometrics = await LocalAuthApi.getBiometrics();

        final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Availability'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildText('Biometrics', isAvailable),
                buildText('Fingerprint', hasFingerprint),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget buildAuthPasscode(BuildContext context) => buildButton(
        text: 'mobile passcode',
        icon: Icons.pin,
        onClicked: () async {
          // final isAuthenticated = await LocalAuthApi.authenticate();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DemoPasscode()),
          );
        },
      );
}
