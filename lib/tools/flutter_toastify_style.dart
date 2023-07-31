import 'package:flutter/material.dart';

class FlutterToastifyStyle {
  static Color get successColor => const Color(0xff01CB67);
  static Color get errorColor => const Color(0xffFE355C);
  static Color get infoColor => const Color(0xff0066FF);
  static Color get defaultColor => Colors.blue;

  static EdgeInsetsGeometry get contentPadding => const EdgeInsets.symmetric(horizontal: 24, vertical: 20);

  static double get iconSize => 20.0;
}
