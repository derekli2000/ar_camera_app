import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:arcameraapp/services/https_requests.dart';
import 'user.dart';

class SecureStoreMixin {

	static void setSecureStore(String key, String value) async {
		final storage = new FlutterSecureStorage();

		await storage.write(key: key, value: value);
	}

	static Future<String> getUsername() async {
		final storage = new FlutterSecureStorage();

		String username = await storage.read(key: 'username');
		return username;
	}

	static void clearSecureStore() async {
		final storage = new FlutterSecureStorage();

		await storage.deleteAll();
	}

	static Future<User> getCurrentUser() async {
		final storage = new FlutterSecureStorage();

		String username = await storage.read(key: 'username');
		String password = await storage.read(key: 'password');

		if (username == null) {
			return new User('', '');
		}
		HttpRequests.authenticateLogin(username, password);

		return new User(username, password);
	}
}