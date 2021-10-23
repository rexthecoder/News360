import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news360/src/resources/assets/fonts.gen.dart';
import 'package:news360/src/presentation/theme/text_styles.dart';

import 'app_colors.dart';

//ThemeMode
var lightTheme = AppTheme.lightTheme();
var darkTheme = AppTheme.darkTheme();

var systemTheme = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
);

var darkSystemTheme = SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: AppColors.blackBackground,
  statusBarColor: AppColors.blackBackground,
  statusBarIconBrightness: Brightness.light,
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

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: AppColors.blackBackground,
      textTheme: _buildBmiTextTheme(base.textTheme),
      primaryColorLight: AppColors.blackBackground,
      primaryColorDark: AppColors.blackBackground,
      scaffoldBackgroundColor: AppColors.blackBackground,
      bottomAppBarColor: AppColors.blackBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.blackBackground,
      ),
      colorScheme: base.colorScheme.copyWith(
        secondaryVariant: AppColors.greyPrimary,
        background: AppColors.blackBackground,
        primary: AppColors.white,
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
