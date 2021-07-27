import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double height;
  final double width;
  final double borderRadii;
  final TextStyle textStyle;
  const CustomRoundedButton({
    Key key,
    this.onPressed,
    this.text = '',
    this.height,
    this.width,
    this.borderRadii = 10,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadii),
        color: Color(0xFF358FA0),
      ),
      child: Material(
        color: Color(0xFF358FA0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadii)),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
