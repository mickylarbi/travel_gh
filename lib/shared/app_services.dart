import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppServices {
  static showAlertDialog(BuildContext context,
      {String title = 'Error', String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content == null ? CupertinoActivityIndicator() : Text(content),
      ),
    );
  }
}

