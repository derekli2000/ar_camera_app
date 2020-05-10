import 'dart:convert';
import 'dart:io';

import 'package:arcameraapp/imports/index.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:http/http.dart' as http;
import 'package:arcameraapp/models/user.dart';

class HttpRequests with SecureStoreMixin{
	String _convertToBase64(String _username, String _password) {
		String credentials = '$_username:$_password';
		Codec<String, String> stringToBase64 = utf8.fuse(base64);
		String encoded = stringToBase64.encode(credentials);
		return encoded;
	}

	Future authenticateLogin(String _username, String _password) async {
		String encoded = _convertToBase64(_username, _password);
		final response = await http.get(
			'http://marinater.herokuapp.com/api/ar/$_username',
			headers: {HttpHeaders.authorizationHeader: 'Basic $encoded'},
		);
		final responseCode = response.statusCode;
		return responseCode;
	}

	void sendMultiFileRequest(String imagePath) async {
		User user = await getCurrentUser();
		var postUri = Uri.parse("https://marinater.herokuapp.com/api/ar/${user.username}");
		var request = new http.MultipartRequest("POST", postUri);
		String encoded = _convertToBase64(user.username, user.password);
		request.headers['authorization'] = 'Basic $encoded';

		request.files.add(await http.MultipartFile.fromPath('capture', imagePath));
		// Change to draggable file
		request.files.add(await http.MultipartFile.fromPath('share_file', imagePath));

		request.send().then((response) {
			print(response.statusCode);
		});
	}
}