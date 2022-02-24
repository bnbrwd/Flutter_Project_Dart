import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  // final TextEditingController _cityTextController = TextEditingController();
  final _cityTextController = TextEditingController();

  // var  city= _cityTextController.text.toString();

  @override
  void initState() {
    _cityTextController.addListener(() {
      final text = _cityTextController.text.toLowerCase();
      _cityTextController.value = _cityTextController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  void dispose() {
    _cityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
          child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: _cityTextController,
                decoration: InputDecoration(
                  labelText: 'Enter a city',
                  hintText: 'Example: Chicago',
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context, _cityTextController.text);
            },
            icon: Icon(Icons.search),
          ),
        ],
      )),
    );
  }
}
