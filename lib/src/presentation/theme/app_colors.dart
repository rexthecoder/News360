import 'package:flutter/material.dart';

/// Return the color when it's hax code is pass to it
/// ``dart
/// base(2536A7) purple in a darker shade
/// ``
Color base(String haxCode) => Color(int.parse('0xff$haxCode'));

/// Host all the colors the app colors
class AppColors {
  static Color white = Colors.white;

  static Color purpleDarker = base('2536A7');
  static Color purplePrimary = base('475AD7');
  static Color purpleLight = base('8A96E5');
  static Color purpleLighter = base('EEF0FB');
  static Color blackDarker = base('22242F');
  static Color blackPrimary = base('333647');
  static Color blackLight = base('44485F');
  static Color blackLightter = base('555A77');
  static Color greyDarker = base('666C8E');
  static Color greyPrimary = base('7C82A1');
  static Color greyLight = base('ACAFC3');
  static Color greyLighter = base('F3F4F6');
  static Color blackBackground = base('001833');
}
