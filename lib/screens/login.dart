import 'package:flutter/material.dart';
import 'package:arcameraapp/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
	@override
	_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
					padding: EdgeInsets.all(20.0),
					child: SingleChildScrollView(
						child: LoginForm(),
					)),
		);
	}
}
