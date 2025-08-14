import 'package:dsc_utility/helper/custom_snackbar.dart';
import 'package:dsc_utility/core/utils/translation/languages.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RotatingSettingsController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  var menuOpen = false.obs;
  bool _menuBusy = false;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  Future<void> toggleMenu(GlobalKey iconKey, BuildContext context) async {
    if (_menuBusy) return;
    _menuBusy = true;

    if (menuOpen.value) {
      // Already open → close
      animationController.reverse();
      menuOpen.value = false;
      _menuBusy = false;
      return;
    }

    animationController.forward();
    menuOpen.value = true;

    // Get icon position
    final RenderBox renderBox = iconKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final result = await showMenu(
      context: Get.context!,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'language',
          child: Row(
            children: [
              Icon(Icons.language, size: 20, color: hexToColor(CustomColors.warningColorBg),),
              const SizedBox(width: 10),
              Text('language'.tr, style: TextStyle(color: hexToColor(CustomColors.warningColorBg)),),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, size: 20),
              const SizedBox(width: 10),
              Text('profile'.tr),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings, size: 20),
              const SizedBox(width: 10),
              Text('settings'.tr),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 20, color: hexToColor(CustomColors.dangerColorBg),),
              const SizedBox(width: 10),
              Text('logout'.tr, style: TextStyle(color: hexToColor(CustomColors.dangerColorBg)),),
            ],
          ),
        ),
      ],
    );

// Handle selected value
    if (result != null) {
      switch (result) {
        case 'language':
          print(Get.currentRoute);
          // Get.toNamed(RouteNames.homePage);
          Get.defaultDialog(
            title: 'changeLanguage'.tr,
            content: Column(
              children: languages.map((lang) {
                return ListTile(
                  title: Text(
                    lang.language,
                    style: themeVariable.titleStyle,
                  ),
                  onTap: () {
                    changeLanguage(lang.symbol);
                    Get.back(); // close dialog
                    CustomSnackbar.success(
                      'languageChanged'.tr,
                    );
                  },
                );
              }).toList(),
            ),
          );
          break;
        case 'profile':
          print("Profile clicked");
          break;
        case 'settings':
          print("Settings clicked");
          break;
        case 'logout':
          logout();
          break;
      }
    }


    animationController.reverse();
    menuOpen.value = false;
    _menuBusy = false;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
