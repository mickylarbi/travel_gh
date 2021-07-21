import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;

  final TextEditingController controller;

  CustomTextFormField({
    Key key,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.enabled,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFF0F0F0)),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFB8BFBF)),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
