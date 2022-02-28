import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File _pickedImage;
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null){
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
    //leave this page i,e back after this page.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            //occupy rest space available.
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0), //remove button bottom space.
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // fit into bottom
            ),
            icon: Icon(Icons.add),
            label: Text('Add place'),
            onPressed: _savePlace,
            //not execute immediately but flutter that should be executed when user press button.
          ),
        ],
      ),
    );
  }
}
