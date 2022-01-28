import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
void CheckValidate(_numberController) {}
class _LoginScreenState extends State<LoginScreen> {
  // final numberController = TextEditingController();
  var size, h, w;
  var _color = false;
  var _validatePhoneInput = false;
  void inputValidate() {
    if (_numberController.text.length >= 10) {
      setState(() {
        _validatePhoneInput = true;
      });
    } else {
      setState(() {
        _validatePhoneInput = false;
      });
    }
  }
  final _numberController = TextEditingController();
  void lengthChecker() {
    if (_numberController.text.length >= 10) {
      setState(() {
        _color = true;
      });
    } else {
      setState(() {
        _color = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // print(_numberController.text);
    size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: w * 0.04, top: h * 0.1),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                      height: 20,
                    ),
                    Container(
                      height: h * 0.087,
                      width: w * 0.911,
                      child: TextFormField(
                        onChanged: (_) => lengthChecker(),
                        // initialValue: "+91",
                        controller: _numberController,
                        decoration: InputDecoration(
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // hintText: "Phone Number",
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.0062,
                    ),
                    Container(
                      height: 0.031 * h,
                      width: 0.45 * w,
                      child: Text(
                        "Otp will be sent to the Number",
                        // textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12),
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
                child: FlatButton(
                  child: Text(
                    'Verify',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                  color: _color ? Colors.yellow : Colors.black26,
                  textColor: Colors.black,
                  onPressed: () {
                    print("Hello Motto");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}