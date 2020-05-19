import 'package:arcameraapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:arcameraapp/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var themeSetting = prefs.getString('themeSetting') ?? 'system';
    var appTheme;
    if (themeSetting == 'light') {
      appTheme = lightTheme;
    } else {
      appTheme = darkTheme;
    }
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(appTheme, themeSetting),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
        title: 'AR File Sharer',
        theme: themeNotifier.getTheme(),
        home: SplashScreen());
  }
}
