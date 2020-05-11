import 'package:arcameraapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:arcameraapp/models/SecureStoreMixin.dart';

class AccountDialog extends StatelessWidget with SecureStoreMixin {
  final String user;

  AccountDialog({this.user});

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
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
              Text(
                '$user',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      clearSecureStore();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()
													),
                          ModalRoute.withName('/'));
                    },
                    child: Text('Log out'),
                  ),
                ),
              ),
              SizedBox(height: 26.0),
            ],
          ),
        ),
        Positioned(
          top: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print('pressed close');
              Navigator.of(context).pop(); // To close the dialog
            },
          ),
        ),
        Positioned(
          left: 50,
          right: 50,
          child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20.0,
              child: Icon(
                Icons.account_circle,
              )),
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
