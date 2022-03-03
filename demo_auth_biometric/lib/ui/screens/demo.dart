import 'package:demo_auth_biometric/services/local_auth_api.dart';
import 'package:demo_auth_biometric/ui/screens/homepage_screen.dart';
import 'package:flutter/material.dart';

class DemoScrenn extends StatefulWidget {
  const DemoScrenn({Key? key}) : super(key: key);

  @override
  _DemoScrennState createState() => _DemoScrennState();
}

class _DemoScrennState extends State<DemoScrenn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAuth();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void getAuth() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    }
  }
}
