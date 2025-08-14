  import 'dart:io';

  import 'package:bitsdojo_window/bitsdojo_window.dart';
  import 'package:dsc_utility/core/routes/app_routes.dart';
  import 'package:dsc_utility/core/utils/translation/translation.dart';
  import 'package:dsc_utility/helper/custom_method.dart';
  import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/widgets/controller/status_controller.dart';
  import 'package:dsc_utility/presentation/widgets/custom_widget.dart';
  import 'package:dsc_utility/presentation/widgets/view/rotating_settings_button.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:window_size/window_size.dart';


  void main() {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowMinSize(const Size(800, 500));
    }

    runApp(MyUtilityApp());

    doWhenWindowReady(() {
      final initialSize = Size(800, 500);
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
      final statusController = Get.put(StatusController());
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'header_name'.tr,
        initialRoute: AppRoutes.splash,
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
                // TOP TITLE BAR
                Container(
                  height: 50,
                  color: AppThemes.theme.primaryColor,
                  child: WindowTitleBarBox(
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
                ),
                // MAIN CONTENT
                Expanded(child: child ?? const SizedBox()),
                // BOTTOM STATUS BAR
                Obx(() {
                  return Container(
                    height: 35,
                    color: AppThemes.theme.primaryColor,
                    alignment: Alignment.centerLeft,
                    // padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                          child: Container(
                            width: 150,
                            color: Colors.white, // background
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              'assets/images/horizontal_logo.png',
                              fit: BoxFit.cover,
                              // width: 105,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: getStatusColor(statusController.status.value), // dynamic color
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                statusController.status.value,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      );
    }
  }
