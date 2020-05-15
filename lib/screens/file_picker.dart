import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import 'camera_screen.dart';

class FilePickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilePickerPageState();
  }
}

class FilePickerPageState extends State<FilePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Open File'),
            onPressed: () async {
              File file = await FilePicker.getFile();
              if (file != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(
                      shareFilePath: file.path,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
