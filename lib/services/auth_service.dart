import 'dart:async';
import 'package:flutter/material.dart';
import 'https_requests.dart';

import 'package:arcameraapp/models/user.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';

class AuthService with SecureStoreMixin {
	HttpRequests httpRequests = new HttpRequests();

	AuthService() {
		print('new AuthService');
	}

	Future<User> getUser() async {
		User u = await getCurrentUser();
		return u;
	}

//	Future logout() {
//		this.currentUser = null;
//		notifyListeners();
//		return Future.value(currentUser);
//	}

	Future createUser(String username, String password) async {
		// TODO: Create a new user and communicate with backend
	}

	Future<int> loginUser({String username, String password}) async {
		var response = await httpRequests.authenticateLogin(username, password);
		if (response == 302) {
			setSecureStore('username', username);
			setSecureStore('password', password);
			return 302;
		} else if (response == 401 || response == 403) {
			return response;
		} else {
			return null;
		}
	}



}