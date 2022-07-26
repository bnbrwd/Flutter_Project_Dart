import 'dart:io' show Platform;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/login_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/otp_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/constant/strings.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  var size, h, w;
  final otpControl = TextEditingController();
  late AnimationController controller;
  void initState() {
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    super.initState();
  }

  late Timer _timer;
  int _start = 30;
  var _resend = true;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _resend = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  var _tokenResponse;

  var _enteredOtp;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _submit() async {}
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  bool isValid = false;
  var token;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;

    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LoginStateSuccess) {
              token = state.loginResponse.data.token;
              // print(state.loginResponse.data.token);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: h * 0.1,
                left: 0.04 * w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 0),
                    child: Text(
                      "Enter the OTP",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.005),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.018,
                  ),
                  Container(
                    child: Text(
                      "We have sent an OTP to 7717743329",
                      style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.004,
                          color: Colors.black38),
                    ),
                  ),
                  Container(
                    // height: h * 0.4,
                    // width: w * 0.8,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Platform.isAndroid
                            ? OTPTextField(
                                length: 6,
                                fieldWidth: w * 0.109,
                                width: w * 0.9,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceBetween,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 15,
                                style: TextStyle(fontSize: 17),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  _enteredOtp = pin;
                                  BlocProvider.of<OtpBloc>(context).add(
                                      Authorized(
                                          enteredOtp: pin, token: token));
                                  // BlocProvider.of<OtpCubit>(context)
                                  //     .isAuthorized(_enteredOtp, token);
                                  // // print("Completed: " + pin);
                                },
                              )
                            : OTPTextField(
                                length: 6,
                                fieldWidth: w * 0.109,
                                width: w * 0.9,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceBetween,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 15,
                                style: TextStyle(fontSize: 17),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                },
                              )),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  value: controller.value,
                                  color: Colors.orange,
                                  semanticsLabel: 'Linear progress indicator',
                                  strokeWidth: 3,
                                ),
                              ),
                              SizedBox(
                                width: w * 0.03,
                              ),
                              Text(
                                "Auto verifying",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: w * 0.06),
                          child: _resend
                              ? Text(
                                  "Resend OTP in ${_start}s ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 10),
                                )
                              : Text(
                                  "Resend OTP now ",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 10),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.25 * h,
                  ),
                  BlocListener<OtpBloc, OtpState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is OtpStateSucess) {
                        if (state.otpResponse.message == "success") {
                          setState(() {
                            isValid = true;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: h * 0.075,
                      // width: double.infinity,
                      width: w * 0.91,
                      child: Platform.isAndroid
                          ? FlatButton(
                              child: BlocBuilder<OtpBloc, OtpState>(
                                builder: (context, state) {
                                  return Text(
                                    'Verify',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                              ),
                              color: Colors.yellow,
                              textColor: Colors.black,
                              onPressed: () {
                                print("tokennnnnnnnnnnnnnnn-----------$token");

                                if (!isValid) {
                                  return _showErrorDialog(
                                      "Entered a Valid Otp");
                                } else {
                                  Navigator.pushNamed(
                                      context, INFORMATION_SCREEN_ROUTE);
                                }
                              })
                          : CupertinoButton(
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              color: Colors.yellow,
                              onPressed: () {
                                // Navigator.pushNamed(
                                //     context, InformationScreen.routeName);
                              },
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
