import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.white,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black,
);


class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  String _themeVal;

  ThemeNotifier(this._themeData, this._themeVal);

  getTheme() => _themeData;
  getThemeVal() => _themeVal;

  setTheme(ThemeData themeData, String val) async {
    _themeData = themeData;
    _themeVal = val;
    notifyListeners();
  }
}