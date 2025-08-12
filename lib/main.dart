import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dsc_utility/core/routes/app_routes.dart';
import 'package:dsc_utility/core/utils/translation/translation.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/widgets/custom_widget.dart';
import 'package:dsc_utility/presentation/widgets/view/rotating_settings_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(800, 600));
  }

  runApp(MyUtilityApp());

  doWhenWindowReady(() {
    final initialSize = Size(800, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'PM Poshan Utility';
    appWindow.show();
  });
}

class MyUtilityApp extends StatelessWidget {
  MyUtilityApp({super.key});

  final buttonColors = WindowButtonColors(
    iconNormal: hexToColor(CustomColors.whiteColor),
    mouseOver: hexToColor(CustomColors.warningColorBg),
    mouseDown: hexToColor(CustomColors.warningColorBg),
    iconMouseOver: hexToColor(CustomColors.whiteColor),
    iconMouseDown: hexToColor(CustomColors.whiteColor),
    normal: AppThemes.theme.primaryColor,
  );

  final closeButtonColors = WindowButtonColors(
    mouseOver: Colors.red.shade700,
    mouseDown: Colors.red.shade900,
    iconNormal: hexToColor(CustomColors.whiteColor),
    iconMouseOver: hexToColor(CustomColors.whiteColor),
    iconMouseDown: hexToColor(CustomColors.whiteColor),
    normal: AppThemes.theme.primaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'header_name'.tr,
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
      theme: AppThemes.theme,
      translationsKeys: AppTranslation.translationsKeys,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.fade,
      builder: (context, child) {
        return WindowBorder(
          color: Colors.white,
          width: 0,
          child: Column(
            children: [
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(
                      child: MoveWindow(
                        child: Container(
                          height: 50,
                          color: AppThemes.theme.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              circleHoverButton(Image.asset(
                                'assets/images/app_logo_transparent.png',
                                fit: BoxFit.contain,
                                width: 24,
                                height: 24,
                              ),),
                              SizedBox(width: 10,),
                              Text(
                                'app_name'.tr,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),


                    RotatingSettingsButton(bgColor: AppThemes.theme.primaryColor),

                    MinimizeWindowButton(colors: buttonColors),
                    MaximizeWindowButton(colors: buttonColors),
                    CloseWindowButton(colors: closeButtonColors),

                  ],
                ),
              ),
              Expanded(child: child ?? const SizedBox()),
            ],
          ),
        );
      },
    );
  }
}
