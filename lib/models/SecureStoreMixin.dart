import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'user.dart';

class SecureStoreMixin {
	final storage = new FlutterSecureStorage();

	void setSecureStore(String key, String value) async {
	 await storage.write(key: key, value: value);
	}

	Future<User> getCurrentUser() async {
		String username = await storage.read(key: 'username');
		String password = await storage.read(key: 'password');
		return new User(username, password);
	}

	Future<Map<String, String>> getAllValuesStore() async {
		Map<String, String> allValues = await storage.readAll();
		return allValues;
	}
}