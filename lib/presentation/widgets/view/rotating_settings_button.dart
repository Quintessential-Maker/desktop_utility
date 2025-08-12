import 'package:dsc_utility/presentation/widgets/controller/rotating_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';

class RotatingSettingsButton extends StatelessWidget {
  final Color bgColor;
  final GlobalKey _iconKey = GlobalKey();

  RotatingSettingsButton({Key? key, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RotatingSettingsController());

    return GestureDetector(
      onTap: () => controller.toggleMenu(_iconKey, context),
      child: Container(
        key: _iconKey,
        color: bgColor,
        padding: const EdgeInsets.all(5),
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 0.25).animate(
            CurvedAnimation(
              parent: controller.animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: Icon(
            Icons.settings,
            color: hexToColor(CustomColors.whiteColor),
            size: 20,
          ),
        ),
      ),
    );
  }
}
