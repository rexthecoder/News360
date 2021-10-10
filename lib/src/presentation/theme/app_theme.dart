import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news360/resources/assets/fonts.gen.dart';
import 'package:news360/src/presentation/theme/text_styles.dart';

import 'app_colors.dart';

//ThemeMode
var lightTheme = ThemeData.light().copyWith(primaryColor: AppColors.white);
var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
);
var mySystemThemeHeaderBlue = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
);

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: AppColors.white,
      textTheme: _buildBmiTextTheme(base.textTheme),
      primaryColorLight: AppColors.blackPrimary,
      primaryColorDark: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: base.colorScheme.copyWith(
        secondaryVariant: AppColors.greyPrimary,
        background: AppColors.white,
        primary: AppColors.blackPrimary,
      ),
    );
  }

  // Method to create and return the text styles
  static _buildBmiTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline6: kHeadline6Style,
          headline5: kHeadline5TextStyle,
          headline4: kHeadline4TextStyle,
          headline3: kHeadline3TextStyle,
          bodyText1: kBodyText1Style,
          bodyText2: kBodyText2Style,
          button: kButtonTextStyle,
          caption: kCaptionStyle,
        )
        .apply(
          fontFamily: FontFamily.proximaRegular,
        );
  }
}
