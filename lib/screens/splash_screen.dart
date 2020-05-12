import 'package:arcameraapp/models/user.dart';
import 'package:arcameraapp/screens/login.dart';
import 'package:arcameraapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'dart:async';
import 'camera_screen.dart';
import 'file_picker.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  String user;
  StreamSubscription _intentDataStreamSubscription;
  String sharedImagePath;
  String sharedText;

  @override
  void initState() {
    super.initState();
    handleInitialState();
    handleShareIntent();
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

  void handleShareIntent() {
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        sharedImagePath = (value?.map((f) => f.path)?.join(",") ?? "");
        print("Shared:" + (value?.map((f) => f.path)?.join(",") ?? ""));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        sharedImagePath = (value?.map((f) => f.path)?.join(",") ?? "");
        print("Shared:" + (value?.map((f) => f.path)?.join(",") ?? ""));
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          setState(() {
            sharedText = value;
            print("Shared: $sharedText");
          });
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        sharedText = value;
        print("Shared: $sharedText");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    if (sharedImagePath != null && sharedText != null) {
      return Scaffold(
        body: Container(
          child: CameraScreen(shareFilePath: sharedImagePath,),
        ),
      );
    }

    return Scaffold(
      body: Container(
        child: FilePickerPage(),
      ),
    );
  }
}
