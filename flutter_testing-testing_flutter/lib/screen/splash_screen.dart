import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapido_screen_using_bloc_architecture/screen/login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var size, h, w;

  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    // print(" the height is ${h} and the width is ${w}");
    // print(" the height is ${h * 0.314} and the width is ${w * 0.40}");

    return Platform.isAndroid
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: w * 0.25,
                      top: h * 0.085,
                      right: w * 0.25,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          
                          child: Image.asset(
                            "assets/image/Rectangle.png",
                            height: 0.314 * h,
                            width: 0.5 * w,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(
                          height: h * 0.06,
                        ),
                        Container(
                          child: Image.asset(
                            "assets/image/RapidoLogo.png",
                            height: 0.2 * h,
                            width: 0.66 * w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Text(
                        //   "Splash Screen Logo",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 20),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : CupertinoPageScaffold(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: w * 0.25,
                      top: h * 0.085,
                      right: w * 0.25,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: 0.30 * w, vertical: 0.085 * h),
                          // width: 0.314 * w,
                          // height: 0.314 * h,
                          child: Image.asset(
                            "assets/image/Rectangle.png",
                            height: 0.3 * h,
                            width: 0.6 * w,
                            fit: BoxFit.fill,
                          ),
                        ),

                        SizedBox(
                          height: h * 0.06,
                        ),
                        Container(
                          child: Image.asset(
                            // "assets/image/RapidoLogo.png",
                            "assets/image/RapidoLogo.png",
                            height: 0.2 * h,
                            width: 0.66 * w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Text(
                        //   "Splash Screen Logo",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 20),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
