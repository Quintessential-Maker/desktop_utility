import 'package:dsc_utility/core/constants/preferences.dart';
import 'package:dsc_utility/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashController extends GetxController {
  final prefs = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = prefs.read(Preferences.AUTHORIZATION_TOKEN);

    if (token != null && !_isTokenExpired(token)) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  bool _isTokenExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true;
    }
  }
  
}
