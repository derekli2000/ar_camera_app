/*
	This file allows for the validation of inputted data
 */

import 'package:arcameraapp/screens/camera_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:arcameraapp/imports/index.dart';
import 'package:arcameraapp/services/auth_service.dart';


class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
	// Create a global key that uniquely identifies the Form widget
	// and allows validation
	final _formKey = GlobalKey<FormState>();

	// Saved preferences
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

	// Text Input Fields Controllers
	final TextEditingController _usernameController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	// Fields
	String _username;
	String _password;

	@override
	void dispose() {
		_usernameController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	// Helper functions for login verification
	Future _buildErrorDialog(BuildContext context, _message) {
		return showDialog<void>(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text('Error Message'),
					content: Text(_message),
					shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.all(Radius.circular(8.0))
					),
					actions: [
						FlatButton(
								child: Text('Cancel'),
								onPressed: () {
									Navigator.of(context).pop();
								})
					],
				);
			},
		);
	}

	void _displayErrors(int val) async {
		switch (val) {
			case 200:{
				Navigator.push(context,
						MaterialPageRoute(builder: (BuildContext context) => CameraScreen()));
				break;
			}
			case 401: {
				print('case 401 incorrect');
				_buildErrorDialog(context, 'Username or Password are incorrect');
				break;
			}
			case 403: {
				print('case 403 incorrect');
				_buildErrorDialog(context, 'File access denied');
				break;
			}
			default: {
				print('case default incorrect');
				_buildErrorDialog(context, 'Unknown error');
				break;
			}

		}
	}

	_displayLoadingIndicator(BuildContext context) {
		return new Center(child: CircularProgressIndicator());
	}

  @override
  Widget build(BuildContext context) {
    return Form(
			key: _formKey,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'Login Page',
						style: TextStyle(fontSize: 20.0),
					),
					SizedBox(height: 120.0),
					/*
			  				[Username] input field
			  		*/
					TextFormField(
						controller: _usernameController,
						onSaved: (value) => _username = value,
						validator: (value) {
							if (value.isEmpty) {
								return 'Please enter a username';
							}
							return null;
						},
						decoration: InputDecoration(
								border: OutlineInputBorder(
										borderRadius: BorderRadius.all(Radius.circular(8.0))),
								labelText: 'Username'),
					),
					SizedBox(
						height: 20.0,
					),
					/*
			  				[Password] input field
			  		*/
					TextFormField(
						controller: _passwordController,
						onSaved: (value) => _password = value,
						validator: (value) {
							if (value.isEmpty) {
								return 'Please enter a password';
							}
							return null;
						},
						decoration: InputDecoration(
								border: OutlineInputBorder(
										borderRadius: BorderRadius.all(Radius.circular(8.0))),
								labelText: 'Password'),
						obscureText: true,
					),
					ButtonBar(
						children: <Widget>[
							RaisedButton(
								child: Text('LOGIN'),
								shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.all(Radius.circular(8.0))),
								elevation: 5.0,
								onPressed: () async {
									final form = _formKey.currentState;
									form.save();
									// Validate returns true if the form is valid, otherwise false.
									if (form.validate()) {
										print('$_username $_password');
										_displayLoadingIndicator(context);
										AuthService a = new AuthService();
										var response = await a.loginUser(
												username: _username,
												password: _password
										);
										print('Response $response');
										_displayErrors(response);
									}
								},
							)
						],
					)
				],
			),
		);
  }

}