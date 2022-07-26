// ignore_for_file: prefer_const_constructors

import 'package:authentication_bloc_rxdart/bloc/register_bloc.dart';
import 'package:authentication_bloc_rxdart/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Color(0x164B5785),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25),
                StreamBuilder<Object>(
                    //here we will listen loginEmail to check updation using getter
                    stream: bloc.name,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          labelText: 'Name',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onChanged: bloc.changeName,
                        //value goes inside  changeName setter
                      );
                    }),
                SizedBox(height: 25),
                StreamBuilder<Object>(
                    stream: bloc.email,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          labelText: 'Email',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onChanged: bloc.changeEmail,
                        //value goes inside  changeEmail setter
                      );
                    }),
                SizedBox(height: 25),
                StreamBuilder<Object>(
                    stream: bloc.phoneNumber,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone number',
                          labelText: 'phone number',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onChanged: bloc.changePhoneNumber,
                        //value goes inside  changePhoneNumber setter
                      );
                    }),
                SizedBox(height: 25),
                StreamBuilder<Object>(
                    stream: bloc.password,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'password',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onChanged: bloc.changePassword,
                        //value goes inside  changePassword setter
                      );
                    }),
                SizedBox(height: 25),
                StreamBuilder<Object>(
                    stream: bloc.confirmPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          labelText: 'confirm password',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          suffixIcon: IconButton(
                            icon: isVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: bloc.changeConfirmPassword,
                        //value goes inside  changeConfirmPassword setter
                      );
                    }),
                SizedBox(height: 25),
                _buildButton(),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                        text: "Login here",
                        style: TextStyle(color: Colors.blueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          })
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit();
                  },
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : Color(0xFF6994FF),
              ),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
          );
        });
  }
}
