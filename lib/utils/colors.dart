import 'package:flutter/material.dart';

class ContactColor {
  static List<Color> _colors = [
    Color(0xFFDB4437),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF673AB7),
    Color(0xFF3F51B5),
    Color(0xFF4285F4),
    Color(0xFF039BE5),
    Color(0xFF0097A7),
    Color(0xFF009688),
    Color(0xFF0F9D58),
    Color(0xFF689F38),
    Color(0xFFEF6C00),
    Color(0xFFFF5722),
    Color(0xFF757575),
  ];

  static List<Color> get allColors {
    return _colors;
  }

  static Color getColor(String contactId) {
    final int color = (contactId.hashCode % ContactColor.allColors.length);
    return ContactColor.allColors.elementAt(color);
  }
}
