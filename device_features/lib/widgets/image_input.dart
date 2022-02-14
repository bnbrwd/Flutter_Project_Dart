import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      // _storedImage = imageFile as File;
      _storedImage = File(imageFile.path);
      //convert pic file to regular file.
      print('stored image---$_storedImage');
      //stored image---File: '/data/user/0/com.example.device_features/cache/scaled_0257796f-9086-4e4c-bc31-dd0f6df166098931265609263746329.jpg'
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // print(appDir);Directory: '/data/user/0/com.example.device_features/app_flutter'
    // space for app in device
    final fileNameWithExtension = path.basename(imageFile.path);
    // print(fileName);scaled_7d5c1ca0-dca3-4d47-9111-73bfcf4d7ceb7552469672176804227.jpg
    final localImage = await File(imageFile.path)
        .copy('${appDir.path}/$fileNameWithExtension');
    //  final savedImage = await _storedImage.copy('$appDir/$fileNameWithExtension');
    //image saved in final destination.
    print('localImage---$localImage');

    
  }

  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: TextButton.styleFrom(primary: Colors.deepOrange),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
