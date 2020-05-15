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
		User u = await SecureStoreMixin.getCurrentUser();
		return u;
	}

	Future createUser(String username, String password) async {
		// TODO: Create a new user and communicate with backend
	}

	Future<int> loginUser({String username, String password}) async {
		var response = await HttpRequests.authenticateLogin(username, password);
		if (response == 302) {
			SecureStoreMixin.setSecureStore('username', username);
			SecureStoreMixin.setSecureStore('password', password);
			return 302;
		} else if (response == 401 || response == 403) {
			return response;
		} else {
			return null;
		}
	}



}