import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hint;

  CustomTextField(
      {@required this.controller,
      @required this.hint,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        ),
      ),
    );
  }
}
