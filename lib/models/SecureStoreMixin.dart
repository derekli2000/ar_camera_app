import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'user.dart';

class SecureStoreMixin {
	final storage = new FlutterSecureStorage();

	void setSecureStore(String key, String value) async {
	 await storage.write(key: key, value: value);
	}

	Future<String> getUsername() async {
		String username = await storage.read(key: 'username');
		return username;
	}

	void clearSecureStore() async {
		await storage.deleteAll();
	}

	Future<User> getCurrentUser() async {
		String username = await storage.read(key: 'username');
		String password = await storage.read(key: 'password');

		if (username == null) {
			return new User('', '');
		}

		return new User(username, password);
	}
}