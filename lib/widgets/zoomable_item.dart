import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class ZoomableItem extends StatefulWidget {
	final Widget child;

	const ZoomableItem({Key key, this.child}) : super(key: key);

	@override
	_ZoomableItemState createState() => _ZoomableItemState();
}

class _ZoomableItemState extends State<ZoomableItem> {
	Matrix4 matrix = Matrix4.identity();

	@override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
			onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
				setState(() {
					matrix = m;
				});
			},
			child: Transform(
				transform: matrix,
				child: widget.child,
			),
		);
  }

}