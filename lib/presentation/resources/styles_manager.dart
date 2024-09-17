import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, FontWeight fontWeight, Color color, String fontFamily) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12,
    String fontFamily = FontFamily.montserrat,
    required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, fontFamily);
}

// medium style
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    String fontFamily = FontFamily.montserrat,
    required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color, fontFamily);
}

// medium style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12,
    String fontFamily = FontFamily.montserrat,
    required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color, fontFamily);
}

// bold style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12,
    String fontFamily = FontFamily.montserrat,
    required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color, fontFamily);
}

// semiBold style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12,
    String fontFamily = FontFamily.montserrat,
    required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color, fontFamily);
}
