import 'package:flutter/material.dart';

const double defaultpd = 8.0;

Color mapSeverityToColor(String severity) {
  switch (severity) {
    case '0':
      return Color(0xFF97AAB3); // not classified
    case '1':
      return Color(0xFF7499FF); // information
    case '2':
      return Color(0xFFFFC859); // warning
    case '3':
      return Color(0xFFFFA059); // average
    case '4':
      return Color(0xFFE97659); // high
    case '5':
      return Color(0xFFE45959); // disaster
    default:
      return Colors.grey; // Cor padrão caso não haja correspondência
  }
}
