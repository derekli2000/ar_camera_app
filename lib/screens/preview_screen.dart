import 'dart:io';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:arcameraapp/widgets/zoomable_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arcameraapp/services/https_requests.dart';

import 'file_picker.dart';

class PreviewImageScreen extends StatefulWidget with SecureStoreMixin {
  final String imagePath;
  final String sharedImagePath;

  PreviewImageScreen({Key key, this.imagePath, this.sharedImagePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PreviewImageScreenState();
  }
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  HttpRequests httpRequests = new HttpRequests();
  GlobalKey _filePosition = new GlobalKey();
  String x;
  String y;
  String user;

  @override
  void initState() {
    super.initState();
    SecureStoreMixin.getUsername().then((String u) {
      setState(() {
        user = u;
      });
    });
  }

  _confirmSend(BuildContext context, String imagePath, String sharedImagePath) {
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
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                final RenderBox filePositionBox =
                    _filePosition.currentContext.findRenderObject();
                final positionFile = filePositionBox.localToGlobal(Offset.zero);
                x = positionFile.dx.toString();
                y = positionFile.dy.toString();
                HttpRequests.sendMultiFileRequest(
                    imagePath, sharedImagePath, x, y);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FilePickerPage(
                              user: user,
                            )),
                    ModalRoute.withName('/FilePickerPage'));
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Image shareImg = Image.file(
      File(widget.sharedImagePath),
      scale: 10.0,
      fit: BoxFit.cover,
    );

    return Stack(children: <Widget>[
      Image.file(
        File(widget.imagePath),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ZoomableItem(
                child: Container(
                    child: OverflowBox(
                        minWidth: 0.0,
                        minHeight: 0.0,
                        maxWidth: double.infinity,
                        child: ClipRRect(
                            key: _filePosition,
                            borderRadius: BorderRadius.circular(8.0),
                            child: shareImg))),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.share),
            onPressed: () {
              print("pressed send");
              _confirmSend(context, widget.imagePath, widget.sharedImagePath);
            }),
      ),
    ]);
  }
}
