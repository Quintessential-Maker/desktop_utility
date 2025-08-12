import 'dart:ui';

import 'package:get/get.dart';

final List<LanguageModel> languages = [
  LanguageModel("English", "en_US"),
  LanguageModel("हिन्दी", "hi"),
];

void changeLanguage(String langCode) {
  final localeParts = langCode.split('_');
  var locale = localeParts.length > 1
      ? Locale(localeParts[0], localeParts[1])
      : Locale(localeParts[0]);
  Get.updateLocale(locale);
}


class LanguageModel {
  LanguageModel(
      this.language,
      this.symbol,
      );

  String language;
  String symbol;
}