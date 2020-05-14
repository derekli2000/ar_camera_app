import 'dart:convert';
import 'dart:io';
export 'package:path/path.dart' show join;
export 'package:path_provider/path_provider.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:http/http.dart' as http;
import 'package:arcameraapp/models/user.dart';
import 'package:cookie_jar/cookie_jar.dart';

class HttpRequests with SecureStoreMixin{
	var cj = new CookieJar();

	String _convertToBase64(String _username, String _password) {
		String credentials = '$_username:$_password';
		Codec<String, String> stringToBase64 = utf8.fuse(base64);
		String encoded = stringToBase64.encode(credentials);
		return encoded;
	}

	String _concatCookies(List<Cookie> cookies) {
		String result = '';
		for (Cookie c in cookies) {
			result += c.value;
		}
		return result;
	}

	Future authenticateLogin(String _username, String _password) async {
		var postUri = Uri.parse('http://ar-trackpad.herokuapp.com/auth/login');
		final request = new http.MultipartRequest('POST', postUri);
		request.headers['cookie'] = _concatCookies(cj.loadForRequest(postUri));
		request.fields['username'] = _username;
		request.fields['password'] = _password;
		request.followRedirects = true;
		final response = await request.send();
		var cookie = Cookie.fromSetCookieValue(response.headers['set-cookie']);
		List<Cookie> cookies = [cookie];
		cj.saveFromResponse(postUri, cookies);
		return response.statusCode;

	}

	void sendMultiFileRequest(String imagePath, String sharedImagePath, String x, String y, [File internalFile]) async {
		internalFile ??= null;
		User user = await getCurrentUser();
		var postUri = Uri.parse('http://ar-trackpad.herokuapp.com/user/${user.username}');
		var request = new http.MultipartRequest('POST', postUri);
		
		request.headers['cookie'] = _concatCookies(cj.loadForRequest(postUri));
		request.headers['x'] = x;
		request.headers['y'] = y;
		request.files.add(await http.MultipartFile.fromPath('capture', imagePath));

		if (internalFile != null) {
			request.files.add(await http.MultipartFile.fromPath('share_file', internalFile.path));
		} else {
			request.files.add(await http.MultipartFile.fromPath('share_file', sharedImagePath));
		}

		request.send().then((response) {
			print(response.statusCode);
		});
	}
}