import 'package:flutter/material.dart';

class AutoCompleteConfig {
  final Color? primaryColor;
  final Color suggestionBgColor;
  final TextStyle? inputStyle;
  final String? hintText;
  final TextStyle? suggestionTextStyle;
  final double borderRadius;
  final double maxHeight;
  final double suggestionMaxHeight;
  final double maxWidth;
  final Icon? icon;

  const AutoCompleteConfig({
    this.primaryColor,
    this.suggestionBgColor = Colors.white,
    this.inputStyle,
    this.hintText,
    this.suggestionTextStyle,
    this.borderRadius = 12,
    this.maxWidth = double.infinity,
    this.suggestionMaxHeight = 250,
    this.maxHeight = 50,
    this.icon,
  });
}