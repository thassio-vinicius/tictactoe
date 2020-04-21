import 'package:flutter/cupertino.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_convertHexToColor(hexColor));

  static int _convertHexToColor(String color) {
    String tempColor = color.toUpperCase().replaceAll('#', '');
    if (tempColor.length == 6) {
      tempColor = 'FF$tempColor';
    }
    return int.parse(tempColor, radix: 16);
  }
}
