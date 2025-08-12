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

    await showMenu(
      context: Get.context!,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      items: const [
        PopupMenuItem(value: 'profile', child: Text('Profile')),
        PopupMenuItem(value: 'settings', child: Text('Settings')),
        PopupMenuItem(value: 'logout', child: Text('Logout')),
      ],
    );

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
