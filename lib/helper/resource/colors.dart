import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/fonts.dart';
import 'package:flutter/material.dart';

class CustomColors {
  static String backgroundColorPallete = '#FFEEAD';
  static String tealColorBg = '#008080';
  static String primaryDarkColor = '#7A4069';
  static String primaryColor = '#513252';
  static String successColorBg = '#008000';
  static String dangerColorBg = '#914A4C';
  static String secondaryColor = '#CA4E79';
  static String infoColorBg = '#30108e';
  static String backgroundColorSecondary = '#FFC18E';
  static String backgroundColor = '#FFFFFF';
  static String warningColorBg = '#ffb400';
  static String whiteColor = '#FFFFFF';
  static String blackColor = '#000000';
  static String lightGrey = '#dfdfe3';
  static String positionedDotColor = '#9FE2BF';
}

getTheme(int index) {
  return AppThemes.getTheme(
    index,
    index % 2 == 0
        ? hexToColor(CustomColors.primaryColor)
        : hexToColor(CustomColors.secondaryColor),
  );
}

class CustomThemeBase {
  final Color backgroundColor;
  final double backgroundOpacity;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  CustomThemeBase({
    required this.backgroundColor,
    required this.backgroundOpacity,
    required this.titleStyle,
    required this.subTitleStyle,
  });
}

class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: hexToColor(CustomColors.primaryColor),
    colorScheme: ColorScheme(
      primary: hexToColor(CustomColors.primaryColor),
      secondary: hexToColor(CustomColors.secondaryColor),
      surface: hexToColor(CustomColors.whiteColor),
      background: hexToColor(CustomColors.backgroundColor),
      error: hexToColor(CustomColors.dangerColorBg),
      onPrimary: hexToColor(CustomColors.whiteColor),
      onSecondary: hexToColor(CustomColors.whiteColor),
      onSurface: hexToColor(CustomColors.blackColor),
      onBackground: hexToColor(CustomColors.blackColor),
      onError: hexToColor(CustomColors.whiteColor),
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: hexToColor(CustomColors.backgroundColor),

    appBarTheme: AppBarTheme(
      backgroundColor: hexToColor(CustomColors.primaryDarkColor),
      titleTextStyle: TextStyle(
        color: hexToColor(CustomColors.whiteColor),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: hexToColor(CustomColors.whiteColor)),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: hexToColor(CustomColors.primaryColor),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: hexToColor(CustomColors.primaryDarkColor),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: hexToColor(CustomColors.primaryDarkColor),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: hexToColor(CustomColors.primaryColor),
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        color: hexToColor(CustomColors.primaryColor),
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        color: hexToColor(CustomColors.primaryColor),
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: hexToColor(CustomColors.blackColor),
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: hexToColor(CustomColors.secondaryColor),
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: hexToColor(CustomColors.blackColor).withOpacity(0.7),
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        color: hexToColor(CustomColors.whiteColor),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: hexToColor(CustomColors.primaryDarkColor),
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: hexToColor(CustomColors.secondaryColor).withOpacity(0.6),
        fontSize: 14,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: hexToColor(CustomColors.primaryDarkColor)),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: hexToColor(CustomColors.primaryDarkColor)),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: hexToColor(CustomColors.primaryDarkColor)),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexToColor(CustomColors.primaryColor),
        foregroundColor: hexToColor(CustomColors.whiteColor),
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: hexToColor(CustomColors.primaryColor),
        side: BorderSide(color: hexToColor(CustomColors.primaryColor)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: hexToColor(CustomColors.primaryColor),
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    ),

    cardColor: hexToColor(CustomColors.backgroundColor),
  );

  static CustomThemeBase primary(int index, Color colorValue) {
    return CustomThemeBase(
      backgroundColor: colorValue,
      backgroundOpacity: 0.05,
      titleStyle: TextStyle(
        color: colorValue,
        fontSize: 18,
        fontWeight: FontWeight.w900,
        fontFamily: CustomFont.WorkSans_Regular,
      ),
      subTitleStyle: TextStyle(
        color: colorValue.withOpacity(1),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static CustomThemeBase secondary(int index, Color colorValue) {
    return CustomThemeBase(
      backgroundColor: colorValue,
      backgroundOpacity: 0.05,
      titleStyle: TextStyle(
        color: colorValue,
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      subTitleStyle: TextStyle(
        color: colorValue.withOpacity(1),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static CustomThemeBase getTheme(int index, Color colorValue) {
    return index % 2 == 0 ? primary(index, colorValue) : secondary(index, colorValue);
  }
}
