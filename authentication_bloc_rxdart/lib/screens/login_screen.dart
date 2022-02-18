// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:authentication_bloc_rxdart/bloc/login_bloc.dart';
import 'package:authentication_bloc_rxdart/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisibles = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(title: Text('Login Page')),
      body: Form(
        key: _formKey,
        child: Container(
          color: Color(0x17808034),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: avoid_unnecessary_containers
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/image/istockphoto.jpeg',
                      height: 150,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                //used to listen if any changes into streams.
                StreamBuilder<String>(
                    //here we will listen loginEmail to check updation using getter
                    stream: bloc.loginEmail,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          labelText: 'email',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          // errorText: snapshot.hasData ? str : 'Enter email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        // onChanged: (value) => print('Email value = $value'),
                        onChanged: bloc.changeLoginEmail,
                        //value goes inside  changeLoginEmail setter
                      );
                    }),
                SizedBox(height: 30),
                StreamBuilder<String>(
                    //here we will listen loginPassword to check updation
                    stream: bloc.loginPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isVisibles,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          suffixIcon: IconButton(
                            icon: isVisibles
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isVisibles = !isVisibles;
                              });
                            },
                          ),
                        ),
                        // onChanged: (value) => print('Password value = $value'),
                        onChanged: bloc.changeLoginPassword,
                        //value goes inside  changeLoginPassword setter
                      );
                    }),
                SizedBox(height: 30),
                _buildButton(),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Need an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(
                        text: "Register here",
                        style: TextStyle(color: Colors.blueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
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
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit();
                    print('LOGIN');
                  },
            child: Container(
              height: 45,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : Color(0xFFFFE969),
              ),
              child: Text(
                "Login",
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
