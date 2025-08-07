
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/fonts.dart';
import 'package:flutter/material.dart';

class CustomColors {

  static String backgroundColorPallete = '#FFEEAD';
  static String primaryDarkColor = '#7A4069';

  static String primaryColor = '#513252';
  static String successColorBg = '#008000';//32CD32

  static String dangerColorBg = '#914A4C';

  static String secondaryColor = '#CA4E79';
  static String infoColorBg = '#30108e';//6845B5

  static String backgroundColorSecondary = '#FFC18E';
  static String backgroundColor = '#FFFFFF';
  static String warningColorBg = '#ffb400';

  static String whiteColor = '#FFFFFF';
  static String blackColor = '#000000';
  static String lightGrey = '#dfdfe3';

  static String positionedDotColor = '#9FE2BF';
  // static String redColor = '#FF0000';

}

getTheme(int index) {
  return AppThemes.getTheme(
      index,
      index % 2 == 0
          ? hexToColor(CustomColors.primaryColor )
          : hexToColor(CustomColors.secondaryColor));
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

// Define primary and secondary themes
class AppThemes {

  static  ThemeData  theme  = ThemeData(
    primaryColor: hexToColor(CustomColors.primaryColor),
    colorScheme: ColorScheme(
      primary: hexToColor(CustomColors.primaryColor),
      secondary: hexToColor(CustomColors.secondaryColor),
      surface: hexToColor(CustomColors.whiteColor), // Base color
      background: hexToColor(CustomColors.backgroundColor), // Base color
      error: hexToColor(CustomColors.dangerColorBg),
      onPrimary: hexToColor(CustomColors.whiteColor),
      onSecondary: hexToColor(CustomColors.whiteColor),
      onSurface: hexToColor(CustomColors.backgroundColor), // Foreground for surface
      onBackground: hexToColor(CustomColors.backgroundColor), // Foreground for background
      onError: hexToColor(CustomColors.dangerColorBg),
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: hexToColor(CustomColors.primaryDarkColor),
      titleTextStyle: TextStyle(
        color: hexToColor(CustomColors.whiteColor),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: hexToColor(CustomColors.whiteColor)),
    ),
    scaffoldBackgroundColor: hexToColor(CustomColors.backgroundColor),
    // backgroundColor: hexToColor(CustomColors.backgroundColor),

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
      bodyMedium: TextStyle(
        color: hexToColor(CustomColors.secondaryColor),
      ),

    ),
    cardColor: hexToColor(CustomColors.backgroundColor),
    buttonTheme: ButtonThemeData(
      buttonColor: hexToColor(CustomColors.primaryColor),
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Primary theme with separate background, title, and subtitle styles
  static CustomThemeBase primary(int index, Color colorValue) {
    return CustomThemeBase(
      backgroundColor: colorValue,
      backgroundOpacity: 0.05,//.1
      titleStyle: TextStyle(
        color: colorValue,
        fontSize: index % 2 == 0 ? 18 : 18, // Alternate size based on index
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

  // Secondary theme with separate background, title, and subtitle styles
  static CustomThemeBase secondary(int index, Color colorValue) {
    return CustomThemeBase(
      backgroundColor: colorValue,
      backgroundOpacity: 0.05,//.1
      titleStyle: TextStyle(
        color: colorValue,
        fontSize: index % 2 == 0 ? 18 : 18, // Alternate size based on index
        fontWeight: FontWeight.w900,
      ),
      subTitleStyle: TextStyle(
        color: colorValue.withOpacity(1),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Get theme by index for alternating between primary and secondary themes
  static CustomThemeBase getTheme(int index, Color colorValue) {
    return index % 2 == 0 ? primary(index, colorValue) : secondary(index, colorValue);
  }

}














