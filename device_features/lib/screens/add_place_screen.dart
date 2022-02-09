import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

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
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // fit into bottom
            ),
            icon: Icon(Icons.add),
            label: Text('Add place'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
