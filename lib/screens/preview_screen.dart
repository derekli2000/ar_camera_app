import 'dart:io';
import 'dart:typed_data';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:arcameraapp/services/https_requests.dart';

class PreviewImageScreen extends StatefulWidget with SecureStoreMixin {

	final String imagePath;

	PreviewImageScreen({Key key, this.imagePath}): super(key: key);

	@override
  State<StatefulWidget> createState() {
    return _PreviewImageScreenState();
  }
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {

	HttpRequests httpRequests = new HttpRequests();

  @override
  Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: <Widget>[
					Scaffold(
						backgroundColor: Colors.transparent,
						appBar: AppBar(
							backgroundColor: Colors.transparent,
							elevation: 0.0,
							iconTheme: Theme.of(context).iconTheme,
						),

						// The image is stored as a file on the device. Use the `Image.file`
						// constructor with the given path to display the image.
						body: Padding(
							padding: EdgeInsets.all(10.0),
							child: Center(
								child: ClipRRect(
										borderRadius: BorderRadius.circular(8.0),
										child: Image.file(
											File(widget.imagePath),
											scale: 0.5,
										)
								),
							),
						),
					),
				],
			),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.share),
				onPressed: () {
					print("pressed send");
					httpRequests.sendMultiFileRequest(widget.imagePath);

				},
			),
		);
	}
}