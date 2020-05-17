import 'dart:io';

import 'package:arcameraapp/widgets/account_dialog.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import 'camera_screen.dart';

class FilePickerPage extends StatefulWidget {
  final String user;

  const FilePickerPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FilePickerPageState();
  }
}

class FilePickerPageState extends State<FilePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: Center(
            child: RaisedButton(
              child: Text('Open File'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 20.0),
              IconButton(
                color: Theme.of(context).iconTheme.color,
                icon: Icon(
                  Icons.account_circle,
                  size: 30.0,
                ),
                onPressed: () {
                  print('Show account details');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AccountDialog(
                        user: widget.user,
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
