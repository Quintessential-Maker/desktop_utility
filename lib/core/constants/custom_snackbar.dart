import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {

  static void show({
    required String title,
    required String message,
    bool isDismissible = true,
    Duration duration = const Duration(seconds: 3),
    Color? overrideBgColor,
    Widget? overrideIcon,
  }) {
    final normalizedTitle = title.toLowerCase();

    Color bgColor;
    Widget icon;
    String displayTitle;

    switch (normalizedTitle) {
      case 'success': bgColor = hexToColor(CustomColors.successColorBg); icon = const Icon(Icons.check_circle, color: Colors.white); displayTitle = 'success'.tr; break;
      case 'fail': bgColor = hexToColor(CustomColors.dangerColorBg); icon = const Icon(Icons.highlight_off, color: Colors.white); displayTitle = 'fail'.tr; break;
      case 'oops': bgColor = Colors.redAccent; icon = const Icon(Icons.error_outline, color: Colors.white); displayTitle = 'oops'.tr; break;
      case 'warning': bgColor = hexToColor(CustomColors.warningColorBg); icon = const Icon(Icons.warning_amber, color: Colors.white); displayTitle = 'warning'.tr; break;
      case 'info': bgColor = Colors.blueGrey; icon = const Icon(Icons.info_outline, color: Colors.white); displayTitle = 'note'.tr; break;
      case 'network': bgColor = Colors.orange.shade800; icon = const Icon(Icons.wifi_off, color: Colors.white); displayTitle = 'networkError'.tr; break;
      default:
        bgColor = hexToColor(CustomColors.primaryColor);
        icon = const Icon(Icons.notifications, color: Colors.white);
        displayTitle = title; // fallback to passed title
    }

    icon = overrideIcon ?? icon;
    bgColor = overrideBgColor ?? bgColor;

    final isDark =
        ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              displayTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: textColor.withOpacity(0.9),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      duration: duration,
      isDismissible: isDismissible,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 400),
    );
  }

  static void success(String msg) =>
      show(title: 'success', message: msg); // not .tr here because 'success' is used as a type key, not display title

  static void fail(String msg) =>
      show(title: 'fail', message: msg);

  static void oops(String msg) =>
      show(title: 'oops', message: msg);

  static void warning(String msg) =>
      show(title: 'warning', message: msg);

  static void info(String msg) =>
      show(title: 'info', message: msg);

  static void network() =>
      show(title: 'network', message: 'networkError'.tr);

  static void checkInputs() =>
      show(title: 'info', message: 'checkInputs'.tr);

}
