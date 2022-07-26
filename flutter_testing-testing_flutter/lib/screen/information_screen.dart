import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/information_bloc.dart';

class InformationScreen extends StatefulWidget {
  static const routeName = 'information_screen';
  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _formKey = GlobalKey<FormState>();
  var size, h, w;
  var _nextScreen = false;
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Position _currentPosition;
  // String _currentAddress;

  @override
  void initState() {
    super.initState();
    showInit();
    // _getLocation();
    // locationPermission();
    // _handlePermission();
  }

  // Future<void> _getLocation() async {
  //   final locData = await Location().getLocation();
  //   print(locData.latitude);
  // }

  final cityName = FocusNode();

  void showInit() {
    print("Init loaded");
  }

  final nameController = TextEditingController();
  final cityController = TextEditingController();

  Widget andriodTextFormName(context) {
    final bloc = Provider.of<InformationBloc>(context, listen: false);
    return StreamBuilder<String>(
        stream: bloc.name,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changeName,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(cityName);
            },
            decoration: InputDecoration(
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              border: OutlineInputBorder(),
            ),
          );
        });
  }

  Widget andriodTextFormCity(context) {
    final bloc = Provider.of<InformationBloc>(context, listen: false);
    return StreamBuilder<String>(
        stream: bloc.city,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changeCity,
            focusNode: cityName,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(gapPadding: 10),
              border: OutlineInputBorder(),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              errorStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  Widget iosTextFormName(context) {
    return Container(
      height: h * 0.05,
      child: CupertinoTextField(
        padding: EdgeInsets.only(top: 13, left: 5),
        controller: nameController,
      ),
    );
  }

  Widget iosTextFormCity(context) {
    return Container(
      height: h * 0.05,
      child: CupertinoTextField(
        padding: EdgeInsets.only(top: 13, left: 5),
        controller: cityController,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget andriodButton() {
    return FlatButton(
      child: Text(
        'Next',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
      ),
      color: Colors.yellow,
      textColor: Colors.black,
      onPressed: () {
        // print(h * 0.075);
        // if (_formKey.currentState.validate()) {
        //   // Navigator.pushNamed(context, Onboarding.routeName);
        // }
      },
    );
  }

  Widget iosButton() {
    return CupertinoButton(
      child: Text(
        'Next',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.black),
      ),
      color: Colors.yellow,
      onPressed: () {},
    );
  }

  Widget infoScreenLayout(context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: h * 0.07,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 0.02 * w),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Image.asset('assets/image/Ellipse 24.png'),
                          onTap: () {},
                        ),
                      ),
                      Platform.isIOS
                          ? Positioned(
                              top: h * 0.01,
                              left: w * 0.036,
                              child: GestureDetector(
                                child: Image.asset('assets/image/Vector.png'),
                                onTap: () {
                                  () => Navigator.of(context).pop();
                                },
                              ),
                            )
                          : Positioned(
                              top: h * 0.015,
                              left: w * 0.03,
                              child: GestureDetector(
                                child: Image.asset('assets/image/Vector.png'),
                                onTap: () {
                                  () => Navigator.of(context).pop();
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 0.02 * w),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Image.asset('assets/image/Ellipse 24.png'),
                          onTap: () {},
                        ),
                      ),
                      Platform.isIOS
                          ? Positioned(
                              top: h * 0.015,
                              left: w * 0.026,
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Image.asset('assets/image/Vector 1.png'),
                                    SizedBox(
                                      height: h * 0.005,
                                    ),
                                    Image.asset('assets/image/Vector 1.png'),
                                    SizedBox(
                                      height: h * 0.005,
                                    ),
                                    Image.asset('assets/image/Vector 1.png'),
                                  ],
                                ),
                                onTap: () {
                                  Drawer();
                                },
                              ),
                            )
                          : Positioned(
                              top: h * 0.015,
                              left: w * 0.03,
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Image.asset('assets/image/Vector 1.png'),
                                    SizedBox(
                                      height: h * 0.005,
                                    ),
                                    Image.asset('assets/image/Vector 1.png'),
                                    SizedBox(
                                      height: h * 0.005,
                                    ),
                                    Image.asset('assets/image/Vector 1.png'),
                                  ],
                                ),
                                onTap: () {
                                  Drawer(
                                    child: Column(
                                      children: [Text("data")],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: Platform.isIOS
                  ? EdgeInsets.only(left: w * 0.04, top: h * 0.14)
                  : EdgeInsets.only(left: w * 0.04, top: h * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: w * 0.04, top: h * 0.148),
                      child: Text(
                        "Let's get to know you",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: .0375 * h,
                    ),
                    Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: .0125 * h,
                    ),
                    Container(
                      // height: h * 0.075,

                      // width: w * 0.

                      margin: EdgeInsets.only(right: w * 0.04),
                      child: Platform.isAndroid
                          ? andriodTextFormName(context)
                          : iosTextFormName(context),
                    ),
                    // Platform.isIOS ? nameErrorHandler() : Text(""),
                    SizedBox(
                      height: .0375 * h,
                    ),

                    Text("Your City ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(
                      height: .0125 * h,
                    ),
                    Container(
                      // height: h * 0.075,
                      // width: w * 0.911,
                      margin: EdgeInsets.only(right: w * 0.04),
                      child: Platform.isAndroid
                          ? andriodTextFormCity(context)
                          : iosTextFormCity(context),
                    ),
                    // Platform.isIOS ? cityErrorHandler() : Text(""),
                    SizedBox(
                      height: 0.067 * h,
                    ),
                    Container(
                        height: h * 0.075,
                        // width: double.infinity,
                        width: w * 0.91,
                        child:
                            Platform.isAndroid ? andriodButton() : iosButton())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget nameErrorHandler() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: .0125 * h,
  //       ),
  //       SizedBox(
  //         height: .0225 * h,
  //       ),
  //     ],
  //   );
  // }

  // Widget cityErrorHandler() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: .0125 * h,
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;

    return Platform.isAndroid
        ? Scaffold(
            body: infoScreenLayout(context),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            child: infoScreenLayout(context),
            //
          );
  }
}
