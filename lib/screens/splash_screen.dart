
import 'dart:async';

import 'package:arcameraapp/screens/login.dart';
import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_screen.dart';

class SplashScreen extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		// TODO: implement createState
		return _SplashScreenState();
	}
}

class _SplashScreenState extends State<SplashScreen> {
	@override
	void initState() {
		super.initState();
		navigateUser();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(
					image: DecorationImage(
							image: AssetImage("assets/splash.png"),
							fit: BoxFit.cover),
				),
			),
		);
	}

	void startTimer() {
		Timer(Duration(seconds: 1), () {
			navigateUser(); //It will redirect  after 1 seconds
		});
	}

	void navigateUser() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		var status = prefs.getBool('isLoggedIn') ?? false;
		print(status);
		if (status) {
			Navigator.pushReplacement(
					context,
					MaterialPageRoute(builder: (BuildContext context) => CameraScreen())
			);
		} else {
			Navigator.pushReplacement(
					context,
					MaterialPageRoute(builder: (BuildContext context) => LoginPage())
			);
		}
	}
}