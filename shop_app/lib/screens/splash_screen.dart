import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  var size, height, width, statusBarHeight;

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            left: width * 0.22,
            right: width * 0.22,
            top: height * 0.085,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2014/07/25/10/58/shop-401626__340.jpg',
              height: height * 0.32,
              width: width * 0.55,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
