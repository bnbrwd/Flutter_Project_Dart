import 'dart:convert';
import 'dart:async'; //used for timer

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
    //we have token and the token didn't expire, then the user is authenticated.i.e return true otherwise false.
  }

  String get token {
    // because isAfter i.e valid
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyBoyXpsJvOFlUejNkcmP7aTJXJJ88GIJ7Q';
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
        //custom exception
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      //DateTime.now() means current time stamp
      _autoLogout();
      notifyListeners(); //update user interface eg . consumer in main.dart file.
      // storage in SharedPreferences
      final prefs = await SharedPreferences.getInstance(); //get access.
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(), //standaredized date format
      });
      prefs.setString(
          'userData', userData); // write data in storage using set method.
    } catch (error) {
      throw error;
    }
    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  // Future<Void> signup(String email, String password) async {
  //   const url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBoyXpsJvOFlUejNkcmP7aTJXJJ88GIJ7Q';
  //  final response = await http.post(
  //     Uri.parse(url),
  //     body: json.encode(
  //       {
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true,
  //       },
  //     ),
  //   );
  //   print(json.decode(response.body));
  // }

  // Future<Void> login(String email, String password) async {
  //   const url =
  //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBoyXpsJvOFlUejNkcmP7aTJXJJ88GIJ7Q';
  //  final response = await http.post(
  //     Uri.parse(url),
  //     body: json.encode(
  //       {
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true,
  //       },
  //     ),
  //   );
  //   print(json.decode(response.body));
  // }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    //convert String into Map above
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      //here token is not valid.
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['password'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    // here uer is officially treated as logged in.
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
      // if user click on logout then we need to keep _authTimer is null so done here.
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userDate');  //specific
    prefs.clear(); //this will purge all app data from shared preference.
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
      // if already value in time then call cancel existing timer to refresh start.
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    // here logout triggered when timeOut. if we put second =5 then when we logged in after 5 second
    //it will autometically logged out.
  }
}
