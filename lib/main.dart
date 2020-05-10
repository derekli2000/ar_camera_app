import 'package:arcameraapp/screens/camera_screen.dart';
import 'package:arcameraapp/screens/splash_screen.dart';
import 'package:arcameraapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR File Sharer',
      theme: ThemeData.dark(),
      home: SplashScreen()
    );
  }
}

//FutureBuilder(
//        // get the Provider, and call the getUser method
//        future: Provider.of<AuthService>(context).getUser(),
//        // wait for the future to resolve and render the appropriate
//        // widget for HomePage or LoginPage
//        builder: (context, AsyncSnapshot snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            return snapshot.hasData ? CameraScreen() : SplashScreen();
//          } else {
//            return CircularProgressIndicator(
//              backgroundColor: Colors.red,
//            );
//          }
//        },
//      ),