import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'preview_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No Cameras Available");
      }
    }).catchError((e) {
      print('Error: $e.code\nError Message: $e.message');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (cameraController.value.hasError) {
        print('Camera Error: ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget(BuildContext context) {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    var size = MediaQuery.of(context).size;
    double deviceRatio = size.width / size.height;

    return Transform.scale(
      scale: cameraController.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: cameraController.value.aspectRatio,
          child: CameraPreview(cameraController),
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              FloatingActionButton(
                  child: Icon(Icons.camera),
                  onPressed: () {
                    _onCapturePressed(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _onCapturePressed(context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      print(path);
      await cameraController.takePicture(path);

      // If the picture was taken, display it on a new screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewImageScreen(imagePath: path),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  child: _cameraPreviewWidget(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _captureControlRowWidget(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
//    return Scaffold(
//      body: Container(
//        child: SafeArea(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Expanded(
//                flex: 1,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: ClipRRect(
//                      borderRadius: BorderRadius.circular(8.0),
//                      child: _cameraPreviewWidget()
//                  ),
//                ),
//              ),
//              SizedBox(height: 10.0),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
////                  _cameraTogglesRowWidget(),
//                  _captureControlRowWidget(context),
//                ],
//              ),
//              SizedBox(height: 20.0)
//            ],
//          ),
//        ),
//      ),
//    );
  }
}
