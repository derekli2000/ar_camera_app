import 'dart:io';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:arcameraapp/screens/camera_screen.dart';
import 'package:arcameraapp/widgets/zoomable_item.dart';
import 'package:flutter/material.dart';
import 'package:arcameraapp/services/https_requests.dart';

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
  GlobalKey _capturePosition = new GlobalKey();

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
                httpRequests.sendMultiFileRequest(imagePath, sharedImagePath);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CameraScreen()),
                    ModalRoute.withName('/CameraScreen'));
              },
            )
          ],
        ));
  }

  _getPositions() {
    final RenderBox filePositionBox = _filePosition.currentContext.findRenderObject();
    final positionFile = filePositionBox.localToGlobal(Offset.zero);
    final RenderBox capturePos = _capturePosition.currentContext.findRenderObject();
    final positionCapture = capturePos.localToGlobal(Offset.zero);
    print("width: ${capturePos.size}");
    print("POSITION of File: $positionFile, POSITION OF CAPTURE: $positionCapture ");
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
          child: Stack(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              key: _capturePosition,
                              child: Image.file(
                                File(widget.imagePath),
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        ZoomableItem(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            key: _filePosition,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(widget.sharedImagePath),
                                scale: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            _getPositions();
                            _confirmSend(context, widget.imagePath,
                                widget.sharedImagePath);
                          }),
                    )
                  ],
                ),
                SizedBox(height: 20.0)
              ],
            ),
//              Container(
//                child: MovableStackItem(filePath: widget.sharedImagePath)
          ]),
        ),
      ),
    );
  }
}
