import 'dart:io' show Platform;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rapido_screen_using_bloc_architecture/bloc/login_bloc.dart';
import 'package:rapido_screen_using_bloc_architecture/constant/strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

void CheckValidate(_numberController) {}

class _LoginScreenState extends State<LoginScreen> {
  var size, h, w;
  final _formKey = GlobalKey<FormState>();

  final _numberController = TextEditingController();
  Color _color1 = Colors.black;
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    print("Printing the in Init of LoginScreen");
    setState(() {
      FocusNode myFocusNode = new FocusNode();
    });
  }

  Widget getTextAndr(context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<String>(
        stream: bloc.phoneNumber,
        builder: (context, snapshot) {
          return TextFormField(
            focusNode: myFocusNode,
            maxLength: 10,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.length < 10 ||
                  value.length > 10) {
                return 'Number Invalid';
              }
              return null;
            },
            // onChanged: (_) => lengthChecker(),
            onChanged: bloc.changePhoneNumber,
            controller: _numberController,
            decoration: InputDecoration(
              // errorStyle: TextStyle(color: Colors.red),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              counterText: "",
              prefixIcon: SizedBox(
                width: 50,
                child: Center(
                  child: Text(
                    "+91",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              label: Text(
                "Phone Number",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: snapshot.hasError ? Colors.red : Colors.green,
                  // color: _validatePhoneInput ? Colors.red : Colors.green,
                ),
              ),
              border: OutlineInputBorder(),
              // focusColor: Colors.green,
              // labelStyle: TextStyle(
              //     color: myFocusNode.hasFocus ? Colors.black45 : Colors.green),
              focusedBorder: OutlineInputBorder(
                borderSide: snapshot.hasError
                    ? new BorderSide(color: Colors.red)
                    : new BorderSide(color: Colors.green),
              ),
            ),

            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          );
        });
  }

  Widget cupertinoField(context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
        stream: bloc.phoneNumber,
        builder: (context, snapshot) {
          return CupertinoTextField(
            // padding: EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
              border: snapshot.hasError
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.black54),
            ),
            placeholder: "Phone number",
            prefix: SizedBox(
              width: 50,
              child: Center(
                child: Text(
                  "+91",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            maxLength: 10,
            onChanged: (_) => bloc.changePhoneNumber,
            controller: _numberController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          );
        });
  }

  Widget cupertButton() {
    return StreamBuilder<LoginBloc>(
        stream: null,
        builder: (context, snapshot) {
          return CupertinoButton(
            child: Text(
              'Verify',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            color: snapshot.hasError || !snapshot.hasData
                ? Colors.black26
                : Colors.yellow,
            onPressed: () {},
            // BlocProvider.of<LoginBloc>(context).add(
            //           LoginEventRequested(
            //             phoneNumber: _numberController.text,
            //           ),
            //         );

            //         Navigator.pushNamed(
            //           context,
            //           OTP_SCREEN_ROUTE,
            //         );
          );
        });
  }

  Widget andriodButton(context) {
    final bloc = BlocProvider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
      stream: bloc.phoneNumber,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasError || !snapshot.hasData
              ? null
              : () {
                  BlocProvider.of<LoginBloc>(context).add(
                    LoginEventRequested(
                      phoneNumber: _numberController.text,
                    ),
                  );

                  Navigator.pushNamed(
                    context,
                    OTP_SCREEN_ROUTE,
                  );
                },
          child: Container(
            height: 45,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(6),
              color: snapshot.hasError || !snapshot.hasData
                  ? Colors.grey
                  : Colors.yellow,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget layoutBoth(context) {
    return Container(
      margin: EdgeInsets.only(left: w * 0.04, top: h * 0.1),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    "Login to Your account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Container(
                      height: Platform.isIOS ? h * 0.05 : null,
                      width: w * 0.911,
                      child: Platform.isAndroid
                          ? getTextAndr(context)
                          : cupertinoField(context)),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Container(
                    height: 0.031 * h,
                    // width: 0.45 *
                    margin: EdgeInsets.only(right: w * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Otp will be sent to the Number",
                          // textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.23),
            Container(
              margin: EdgeInsets.only(right: w * 0.04),
              height: h * 0.075,
              // width: double.infinity,
              width: w * 0.91,
              // Buttton resemble here.
              child:
                  Platform.isAndroid ? andriodButton(context) : cupertButton(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(_numberController.text);
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    // final bloc = Provider.of<LoginBloc>(context, listen: false);

    return Platform.isAndroid
        ? Scaffold(
            body: SingleChildScrollView(
              child: layoutBoth(context),
            ),
          )
        : CupertinoPageScaffold(
            child: SingleChildScrollView(child: layoutBoth(context)),
          );
  }
}
