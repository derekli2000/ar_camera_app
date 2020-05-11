////import 'index.dart';
////
////Future<void> main() async {
////	// Ensure that plugin services are initialized so that `availableCameras()`
////	// can be called before `runApp()`
////	WidgetsFlutterBinding.ensureInitialized();
////
////	// Obtain a list of the available cameras on the device.
////	final cameras = await availableCameras();
////
////	// Get a specific camera from the list of available cameras.
////	final firstCamera = cameras.first;
////
////	runApp(
////		MaterialApp(
////			theme: ThemeData(),
////			darkTheme: ThemeData.dark(),
////			home: TakePictureScreen(
////				// Pass the appropriate camera to the TakePictureScreen widget.
////				camera: firstCamera,
////			),
////		),
////	);
////}
////
////import 'package:arcameraapp/imports/index.dart';
//
////// A screen that allows users to take a picture using a given camera.
////class TakePictureScreen extends StatefulWidget {
////	final CameraDescription camera;
////
////	const TakePictureScreen({
////		Key key,
////		@required this.camera,
////	}) : super(key: key);
////
////	@override
////	TakePictureScreenState createState() => TakePictureScreenState();
////}
////
////class TakePictureScreenState extends State<TakePictureScreen> {
////	// File sharing intent handler
////	StreamSubscription _intentDataStreamSubscription;
////	List<SharedMediaFile> _sharedFiles;
////	bool _hasSharedFilesFromShareIntent = false;
////
////	// Camera controllers
////	CameraController _controller;
////	Future<void> _initializeControllerFuture;
////
////	@override
////	void initState() {
////		super.initState();
////
////		// For sharing images coming from outside the app while the app is in the memory
////		_intentDataStreamSubscription =
////				ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> value) {
////					setState(() {
////						print("Shared:" + (_sharedFiles?.map((f)=> f.path)?.join(",") ?? ""));
////						_sharedFiles = value;
////						_hasSharedFilesFromShareIntent = true;
////					});
////				}, onError: (err) {
////					print("getIntentDataStream error: $err");
////				});
////
////		// For sharing images coming from outside the app while the app is closed
////		ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
////			setState(() {
////				_sharedFiles = value;
////				_hasSharedFilesFromShareIntent = true;
////			});
////		});
////
////
////		// To display the current output from the Camera,
////		// create a CameraController.
////		_controller = CameraController(
////			// Get a specific camera from the list of available cameras.
////			widget.camera,
////			// Define the resolution to use.
////			ResolutionPreset.ultraHigh,
////		);
////
////		// Next, initialize the controller. This returns a Future.
////		_initializeControllerFuture = _controller.initialize();
////	}
////
////	@override
////	void dispose() {
////		// Dispose of the stream subscription
////		_intentDataStreamSubscription.cancel();
////
////		// Dispose of the controller when the widget is disposed.
////		_controller.dispose();
////		super.dispose();
////	}
////
////	@override
////	Widget build(BuildContext context) {
////		return Scaffold(
////			// Wait until the controller is initialized before displaying the
////			// camera preview. Use a FutureBuilder to display a loading spinner
////			// until the controller has finished initializing.
////				body: Stack(
////					children: <Widget>[
////						FutureBuilder<void>(
////							future: _initializeControllerFuture,
////							builder: (context, snapshot) {
////								if (snapshot.connectionState == ConnectionState.done) {
////									// If the Future is complete, display the preview.
////									return CameraPreview(_controller);
////								} else {
////									// Otherwise, display a loading indicator.
////									return Center(child: CircularProgressIndicator());
////								}
////							},
////						),
////					],
////				),
////				floatingActionButton: FloatingActionButton(
////					child: Icon(Icons.camera_alt),
////					// Provide an onPressed callback.
////					onPressed: () async {
////						// Take the Picture in a try / catch block. If anything goes wrong,
////						// catch the error.
////						try {
////							// Ensure that the camera is initialized.
////							await _initializeControllerFuture;
////
////							// Construct the path where the image should be saved using the
////							// pattern package.
////							final path = join(
////								// Store the picture in the temp directory.
////								// Find the temp directory using the `path_provider` plugin.
////								(await getTemporaryDirectory()).path,
////								'${DateTime.now()}.png',
////							);
////
////							// Attempt to take a picture and log where it's been saved.
////							await _controller.takePicture(path);
////
////							// If the picture was taken, display it on a new screen.
////							Navigator.push(
////								context,
////								MaterialPageRoute(
////									builder: (context) => DisplayPictureScreen(imagePath: path),
////								),
////							);
////						} catch (e) {
////							// If an error occurs, log the error to the console.
////							print(e);
////						}
////					},
////				),
////				floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
////	}
////}
////
////// A widget that displays the picture taken by the user.
////class DisplayPictureScreen extends StatelessWidget {
////	final String imagePath;
////
////	const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);
////
////	_uploadFile() async {
////		var postUri = Uri.parse("https://marinater.herokuapp.com/api/share/temp");
////		var request = new http.MultipartRequest("POST", postUri);
////		request.files.add(await http.MultipartFile.fromPath('file', imagePath));
////
////		request.send().then((response) {
////			print(response.statusCode);
////		});
////	}
////
////	@override
////	Widget build(BuildContext context) {
////		return Scaffold(
////			body: Stack(
////				children: <Widget>[
////					Scaffold(
////						backgroundColor: Colors.transparent,
////						appBar: AppBar(
////							backgroundColor: Colors.transparent,
////							elevation: 0.0,
////							iconTheme: Theme.of(context).iconTheme,
////						),
////
////						// The image is stored as a file on the device. Use the `Image.file`
////						// constructor with the given path to display the image.
////						body: Padding(
////							padding: EdgeInsets.all(10.0),
////							child: Center(
////								child: ClipRRect(
////										borderRadius: BorderRadius.circular(8.0),
////										child: Image.file(
////											File(imagePath),
////											scale: 0.5,
////										)
////								),
////							),
////						),
////					),
////				],
////			),
////			floatingActionButton: FloatingActionButton(
////				child: Icon(Icons.share),
////				onPressed: () {
////					print("pressed send");
////					_uploadFile();
////				},
////			),
////		);
////	}
////}
//
//class ExamplePage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return ExamplePageState();
//  }
//
//}
//
//class ExamplePageState extends State<ExamplePage> {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//			body: Column(
//				children: <Widget>[
//					Padding(padding: EdgeInsets.all(20.0), child: Center(child: Text('Hello'),))
//				],
//			),
//		);
//  }
//
//}
