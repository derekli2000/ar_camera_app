import 'package:arcameraapp/themes/themes.dart';
import 'package:arcameraapp/widgets/theme_picker_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0,),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            onPressed: () {
							showDialog(
									context: context,
									builder: (BuildContext context) => ThemePickerDialog());
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.brightness_medium,
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Theme',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
//										Text('$themeSetting', style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),)
                  ],
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
