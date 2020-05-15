import 'dart:io';
export 'package:path/path.dart' show join;
export 'package:path_provider/path_provider.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';

class HttpRequests with SecureStoreMixin {

//	String _convertToBase64(String _username, String _password) {
//		String credentials = '$_username:$_password';
//		Codec<String, String> stringToBase64 = utf8.fuse(base64);
//		String encoded = stringToBase64.encode(credentials);
//		return encoded;
//	}

	static String _concatCookies(List<Cookie> cookies) {
		String result = 'connect.sid=';
		for (Cookie c in cookies) {
			result += c.value;
		}
		return result;
	}

	static Future authenticateLogin(String _username, String _password) async {
		var cj = new CookieJar();

		var postUri = Uri.parse('http://ar-trackpad.herokuapp.com/auth/login');
		final request = new http.MultipartRequest('POST', postUri);
		request.headers['cookie'] = _concatCookies(cj.loadForRequest(postUri));
		request.fields['username'] = _username;
		request.fields['password'] = _password;
		final response = await request.send();
		var cookie = Cookie.fromSetCookieValue(response.headers['set-cookie']);
		print('Cookie value Login: ${cookie.value}');
		List<Cookie> cookies = [cookie];
		cj.saveFromResponse(postUri, cookies);
		return response.statusCode;
	}

	static void sendMultiFileRequest(String imagePath, String sharedImagePath, String x, String y) async {
		var cj = new CookieJar();

		String username = await SecureStoreMixin.getUsername();
		var postUri = Uri.parse('http://ar-trackpad.herokuapp.com/api/user/$username');
		var request = new http.MultipartRequest('POST', postUri);

		request.headers['cookie'] = _concatCookies(cj.loadForRequest(postUri));
		request.headers['x'] = x;
		request.headers['y'] = y;

		print('Cookie value FILE: ${request.headers['cookie']}');

		request.files.add(await http.MultipartFile.fromPath('capture', imagePath));
		request.files.add(await http.MultipartFile.fromPath('share_file', sharedImagePath));

		var response = await request.send();
		print(response.statusCode);
	}
}