import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

Future<void> showMyDialog({
  String title,
  BuildContext context,
  List<Widget> actions,
  String alertMessage,
}) async {
  if (Platform.isAndroid) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertMessage),
              ],
            ),
          ),
          actions: actions,
        );
      },
    );
  } else {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertMessage),
              ],
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
