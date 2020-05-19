import 'package:arcameraapp/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePickerDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ThemeDialogState();
  }
}

class ThemeDialogState extends State<ThemePickerDialog> {
  String _themeSetting = 'dark';

  void onThemeChanged(String value, ThemeNotifier themeNotifier) async {
    if (value == 'dark') {
      themeNotifier.setTheme(darkTheme, value);
    } else if (value == 'light') {
      themeNotifier.setTheme(lightTheme, value);
    } else {
      themeNotifier.setTheme(Theme.of(context), value);
    }

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('themeSetting', value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _themeSetting = themeNotifier.getThemeVal();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child: Container(
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						RadioListTile<String>(
							title: const Text('Light Theme'),
							value: 'light',
							groupValue: _themeSetting,
							onChanged: (String value) {
								themeNotifier.setTheme(lightTheme, value);
								setState(() {
									print('light $_themeSetting');
									_themeSetting = value;
								});
							},
						),
						Divider(),
						RadioListTile<String>(
							title: const Text('Dark Theme'),
							value: 'dark',
							groupValue: _themeSetting,
							onChanged: (String value) {
								print('dark $_themeSetting');
								themeNotifier.setTheme(darkTheme, value);
								setState(() {
									_themeSetting = value;
								});
							},
						),
						Divider(),
						RadioListTile<String>(
							title: const Text('Follow System Theme'),
							value: 'system',
							groupValue: _themeSetting,
							onChanged: (String value) {
								themeNotifier.setTheme(Theme.of(context), value);
								setState(() {
									print('system $_themeSetting');

									_themeSetting = value;
								});
							},
						)
					],
				),
			),
    );
  }
}
