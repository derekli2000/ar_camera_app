import 'dart:io';

import 'package:arcameraapp/widgets/zoomable_item.dart';
import 'package:flutter/material.dart';

class MovableStackItem extends StatefulWidget {
  final String filePath;

  const MovableStackItem({Key key, this.filePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovableStackItemState();
  }
}

class _MovableStackItemState extends State<MovableStackItem> {
  double xPosition = 50;
  double yPosition = 50;
  File file;

  @override
  void initState() {
    file = File(widget.filePath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
          onPanUpdate: (tapInfo) {
            setState(() {
              xPosition += tapInfo.delta.dx;
              yPosition += tapInfo.delta.dy;
            });
          },
          child: ZoomableItem(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(file, scale: 10.0,),
              ),
            ),
          ),
        ),
    );
  }
}
