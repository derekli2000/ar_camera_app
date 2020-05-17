import 'package:arcameraapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';
import 'package:arcameraapp/services/https_requests.dart';

class AccountDialog extends StatelessWidget with SecureStoreMixin {
  final String user;

  AccountDialog({this.user});

  dialogContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width / 1.5,
          padding: EdgeInsets.only(
            top: 28.0,
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          margin: EdgeInsets.only(top: 20.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Top bar in the dialog
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Icon(Icons.account_circle),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$user',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(color: Colors.white),

              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                onPressed: () {
                  HttpRequests.logoutUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      ModalRoute.withName('/'));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    SizedBox(width: 20.0),
                    Text('Log out')
                  ],
                ),
              ),
              SizedBox(height: 26.0),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: dialogContent(context),
    );
  }
}
