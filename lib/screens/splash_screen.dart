import 'dart:async';

import 'package:arcameraapp/models/user.dart';
import 'package:arcameraapp/screens/login.dart';
import 'package:arcameraapp/services/auth_service.dart';
import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  String user;

  @override
  void initState() {
    super.initState();
    handleInitialState();
  }

  @override
  Widget build(BuildContext context) {
    print("first build $user");
    if (user == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover),
          ),
        ),
      );
    }
//
    if (user == '') {
      return Scaffold(
          body: Container(
        child: LoginPage(),
      ));
    }

    return Scaffold(
      body: Container(
        child: CameraScreen(),
      ),
    );
  }

  // Determines whether the user is logged in or not
  void handleInitialState() {
    AuthService a = new AuthService();
    a.getUser().then((User u) {
      setState(() {
        print('handleInitialState: setState(${u.username})');
        user = u.username;
      });
    });
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
