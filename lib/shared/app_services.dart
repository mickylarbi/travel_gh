import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppServices {
  static showAlertDialog(BuildContext context,
      {String title = 'Error',
      String content,
      bool barrierDismissible = true}) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: content == null ? CupertinoActivityIndicator() : Text(content),
      ),
    );
  }

  static List<Widget> getFeaturesFromString(List<String> list) {
    return list.map((e) {
      if (e == 'Features.electricity')
        return Icon(Icons.power, color: Color(0xFF00CAD9), size: 18);
      if (e == 'Features.restroom')
        return FaIcon(FontAwesomeIcons.restroom,
            color: Color(0xFF00CAD9), size: 16);
      if (e == 'Features.refreshment')
        return FaIcon(FontAwesomeIcons.mugHot,
            color: Color(0xFF00CAD9), size: 16);
      if (e == 'Features.wifi')
        return Icon(Icons.wifi, color: Color(0xFF00CAD9), size: 18);
      if (e == 'Features.temperatureControl')
        return Icon(Icons.ac_unit, color: Color(0xFF00CAD9), size: 18);
      //
    }).toList();
  }
}
