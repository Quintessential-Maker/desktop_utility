import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';

class CustomSnackbar {
  static final List<OverlayEntry> _entries = [];

  static void _showOverlay(
      BuildContext context, {
        required String title,
        required String message,
        Duration duration = const Duration(seconds: 3),
        Color bgColor = Colors.orange,
        IconData icon = Icons.info,
      }) {
    final overlay = Overlay.of(context);

    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) {
        int index = _entries.indexOf(entry!);
        return Positioned(
          top: 20.0 + (index * 80), // stack spacing
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300, // 4 inch approx
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _remove(entry!),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    _entries.add(entry);
    overlay.insert(entry);
    Future.delayed(duration, () => _remove(entry!));
  }

  static void _remove(OverlayEntry entry) {
    if (_entries.contains(entry)) {
      _entries.remove(entry);
      entry.remove();
    }
  }

  static void _show(
      BuildContext context, {
        required String title,
        required String message,
        Color? overrideBgColor,
        IconData? overrideIcon,
      }) {
    final normalizedTitle = title.toLowerCase();

    Color bgColor;
    IconData icon;
    String displayTitle;

    switch (normalizedTitle) {
      case 'success':
        bgColor = hexToColor(CustomColors.successColorBg);
        icon = Icons.check_circle;
        displayTitle = 'success'.tr;
        break;
      case 'fail':
        bgColor = hexToColor(CustomColors.dangerColorBg);
        icon = Icons.highlight_off;
        displayTitle = 'fail'.tr;
        break;
      case 'oops':
        bgColor = hexToColor(CustomColors.warningColorBg);
        icon = Icons.error_outline;
        displayTitle = 'oops'.tr;
        break;
      case 'warning':
        bgColor = hexToColor(CustomColors.warningColorBg);
        icon = Icons.warning_amber;
        displayTitle = 'warning'.tr;
        break;
      case 'info':
        bgColor = hexToColor(CustomColors.infoColorBg);
        icon = Icons.info_outline;
        displayTitle = 'note'.tr;
        break;
      case 'network':
        bgColor = hexToColor(CustomColors.warningColorBg);
        icon = Icons.wifi_off;
        displayTitle = 'networkError'.tr;
        break;
      default:
        bgColor = hexToColor(CustomColors.primaryColor);
        icon = Icons.notifications;
        displayTitle = title;
    }

    _showOverlay(
      context,
      title: displayTitle,
      message: message,
      bgColor: overrideBgColor ?? bgColor,
      icon: overrideIcon ?? icon,
    );
  }

  // Public methods (same as old ones)
  static void success(BuildContext context, String msg) =>
      _show(context, title: 'success', message: msg);

  static void fail(BuildContext context, String msg) =>
      _show(context, title: 'fail', message: msg);

  static void oops(BuildContext context, String msg) =>
      _show(context, title: 'oops', message: msg);

  static void warning(BuildContext context, String msg) =>
      _show(context, title: 'warning', message: msg);

  static void info(BuildContext context, String msg) =>
      _show(context, title: 'info', message: msg);

  static void network(BuildContext context) =>
      _show(context, title: 'network', message: 'networkError'.tr);

  static void checkInputs(BuildContext context) =>
      _show(context, title: 'info', message: 'checkInputs'.tr);
}
