import 'dart:io';
import 'dart:typed_data';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:arcameraapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:arcameraapp/services/https_requests.dart';

class PreviewImageScreen extends StatefulWidget with SecureStoreMixin {
  final String imagePath;

  PreviewImageScreen({Key key, this.imagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PreviewImageScreenState();
  }
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  HttpRequests httpRequests = new HttpRequests();

  _confirmSend(BuildContext context, String imagePath) {
    return showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text('Confirm Send?'),
          content: Text('Is this the picture you want to send?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('Confirm'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
              ),
              onPressed: () {
                httpRequests.sendMultiFileRequest(imagePath);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CameraScreen()
                    ),
                    ModalRoute.withName('/CameraScreen'));
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        child: Icon(Icons.share),
                        onPressed: () {
                          print("pressed send");
                          _confirmSend(context, widget.imagePath);
                        }),
                  )
                ],
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
