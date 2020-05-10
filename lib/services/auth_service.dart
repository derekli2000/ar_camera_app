import 'dart:async';
import 'package:flutter/material.dart';
import 'https_requests.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';

class AuthService with ChangeNotifier, SecureStoreMixin {
	var currentUser;
	HttpRequests httpRequests = new HttpRequests();

	AuthService() {
		print('new AuthService');
	}

	Future getUser() {
		return Future.value(currentUser);
	}

	Future logout() {
		this.currentUser = null;
		notifyListeners();
		return Future.value(currentUser);
	}

	Future createUser(String username, String password) async {
		// TODO: Create a new user and communicate with backend
	}

	Future<int> loginUser({String username, String password}) async {
		var response = await httpRequests.authenticateLogin(username, password);
		if (response == 200) {
			this.currentUser = {'username': username};
			setSecureStore('username', username);
			setSecureStore('password', password);
			notifyListeners();
			return 200;
		} else if (response == 401 || response == 403) {
			this.currentUser = null;
			return response;
		} else {
			this.currentUser = null;
			return null;
		}
	}



}