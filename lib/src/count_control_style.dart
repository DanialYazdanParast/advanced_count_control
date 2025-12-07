import 'package:flutter/material.dart';

class CountControlStyle {
  final Color primaryColor;
  final Color backgroundColor;
  final Color contentColor;
  final Color disabledColor;
  final TextStyle textStyle;
  final TextStyle btnTextStyle;
  final double borderRadius;
  final BorderSide? borderSide;
  final List<BoxShadow>? shadows;

  const CountControlStyle({
    this.primaryColor = const Color(0xFFEF394E),
    this.backgroundColor = Colors.white,
    this.contentColor = const Color(0xFFEF394E),
    this.disabledColor = const Color(0xFFE0E0E0),
    this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    this.btnTextStyle = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    this.borderRadius = 8.0,
    this.borderSide = const BorderSide(color: Color(0xFFE0E0E0)),
    this.shadows,
  });
}