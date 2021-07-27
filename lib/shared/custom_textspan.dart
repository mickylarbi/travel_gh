import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {
  final String firstText, secondText;
  final Function onPressed;
  const CustomTextSpan(
      {Key key, this.firstText, this.secondText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (firstText != null) Text(firstText),
          TextButton(onPressed: onPressed, child: Text(secondText))
        ]);
  }
}
