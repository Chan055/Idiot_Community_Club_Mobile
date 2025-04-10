import 'package:flutter/material.dart';

class Textcomponents {
  static Text whiteText({
    required String text,
    required double fontSize,
    required FontWeight fontweight,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontweight,
      ),
    );
  }
}
