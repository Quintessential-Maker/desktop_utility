import 'dart:io';
import 'dart:ui';
import 'package:dsc_utility/core/routes/app_routes.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/widgets/controller/status_controller.dart';
import 'package:dsc_utility/presentation/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';


final prefs = GetStorage();

final List<Color> availableColors = [
  hexToColor(CustomColors.primaryColor),
  hexToColor(CustomColors.primaryDarkColor),
  hexToColor(CustomColors.infoColorBg),
  hexToColor(CustomColors.dangerColorBg),
  // hexToColor(CustomColors.secondaryColor),

  // hexToColor(CustomColors.successColorBg),
  // hexToColor(CustomColors.warningColorBg),
  // hexToColor(CustomColors.darkColorBg),
];
final CustomThemeBase themeVariable = getTheme(0);

Color hexToColor(String hexColor, [double opacity = 1.0]) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hexColor));

  // return Color(int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xFF000000 : 0x00000000));
  return Color(int.parse(hexColor.replaceFirst('#', '0xff'))).withOpacity(opacity);
}

String getCurrentPlatformName() {
  if (Platform.isAndroid) return "Android";
  if (Platform.isIOS) return "iOS";
  if (Platform.isWindows) return "Windows";
  if (Platform.isMacOS) return "macOS";
  if (Platform.isLinux) return "Linux";
  return "Unknown";
}

Future<String> printAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  final version = info.version; // e.g., "3.19.3"
  final buildNumber = info.buildNumber;

  print("✅ App Version: $version");
  print("🛠️ Build Number: $buildNumber");
  return version;
}

void logout() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) => CustomDialog(
      title: 'alert'.tr,
      pButtonText: 'yes'.tr,
      pButtonOnTap: () {
        // If the user confirms logout, clear GetStorage
        GetStorage().erase();
        Get.put(StatusController()).setStatus('notStartedYet'.tr);
        // Navigate to the HomeScreen
        Get.offAllNamed(AppRoutes.splash);
      },
      nButtonOnTap: () => Get.back(),
      description: 'doYouWantToLogout'.tr,
      nButtonText: 'no'.tr,
    ),
  );
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'started and idle':
    case 'available':
      return hexToColor(CustomColors.successColorBg);
    case 'idle':
      return hexToColor(CustomColors.warningColorBg);
    case 'busy':
      return hexToColor(CustomColors.infoColorBg);
    case 'stopped':
      return hexToColor(CustomColors.dangerColorBg);
    case 'completed':
      return hexToColor(CustomColors.tealColorBg);
    case 'oops':
    case 'error':
      return hexToColor(CustomColors.dangerColorBg);
    default:
      return hexToColor(CustomColors.lightGrey);
  }
}


