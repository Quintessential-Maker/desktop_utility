// lib/features/auth/presentation/controllers/login_controller.dart
import 'dart:async';
import 'dart:convert';
import 'package:dsc_utility/core/constants/api_response.dart';
import 'package:dsc_utility/core/constants/custom_snackbar.dart';
import 'package:dsc_utility/core/constants/error_messages.dart';
import 'package:dsc_utility/core/error/app_exception.dart';
import 'package:dsc_utility/core/routes/app_routes.dart';
import 'package:dsc_utility/core/utils/input_validator.dart';
import 'package:dsc_utility/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:dsc_utility/helper/custom_loader.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController(text: '8962875268');//8103685687
  final otpController = TextEditingController();

  final _authRemoteDataSource = AuthRemoteDataSource();


  bool otpSent = false;
  bool canResend = true;
  int resendSeconds = 30;
  Timer? _timer;
  String version = '0.0.0';

  @override
  void onInit() {

    initialize();

    super.onInit();
  }

  Future<void> verifyOtpAndLogin(BuildContext context) async {
    final otp = otpController.text.trim();
    final mobileNumber = mobileController.text.trim();
    final message = InputValidator.validateOtp(otp);

    if (message != null) {
      CustomSnackbar.warning(message);
      return;
    }

    CustomLoader.show(context);

    try {

      final response = await _authRemoteDataSource.verifyOtp(
        mobile: mobileNumber,
        os: getCurrentPlatformName(),
        version: version,
        otp: otp,
      );

      print(response);
      final rawData = response.data;
      late final Map<String, dynamic> parsedData;
      print(rawData);
      if (rawData is String) {
        parsedData = jsonDecode(rawData);
      } else if (rawData is Map<String, dynamic>) {
        parsedData = rawData;
      } else {
        throw AppException(ErrorMessages.unexpectedResponseFormat);
      }
      print(parsedData);
      final apiResponse = ApiResponse.fromJson(parsedData);
      print(apiResponse.message);

      if (!apiResponse.isSuccess) {
        CustomSnackbar.fail(apiResponse.message);
        return;
      }

      CustomSnackbar.success(apiResponse.message);
      final token = apiResponse.token;
      if (token == null || token.isEmpty) {
        CustomSnackbar.oops("Token not found in response");
        return;
      }

      await _authRemoteDataSource.setTokenToPreferences(apiResponse.token!);

      // ✅ Navigate to Home Page after successful verification
      Get.offAllNamed(AppRoutes.xmlSignView);

    } on AppException catch (e) {
      CustomSnackbar.fail(e.message);
    } catch (e) {
      CustomSnackbar.fail(e.toString());
      // CustomSnackbar.fail(ErrorMessages.unexpected);
      debugPrint('OTP verify error: $e');
    } finally {
      CustomLoader.hide(context);
    }
  }

  void requestOTP(BuildContext context) async {
    final mobile = mobileController.text.trim();
    final validationMessage = InputValidator.validateMobile(mobile);

    if (version == '0.0.0') {
      version = await printAppVersion();
    }

    if (validationMessage != null) {
      CustomSnackbar.warning(validationMessage);
      return;
    }

    CustomLoader.show(context); // 👈 loader shuru

    try {

      print(getCurrentPlatformName());
      print(version);

      final response = await _authRemoteDataSource.requestOtp(
        mobile: mobile,
        os: getCurrentPlatformName(),
        version: version,
      );
      print(response);

      final rawData = response.data;
      late final Map<String, dynamic> parsedData;

      if (rawData is String) {
        parsedData = jsonDecode(rawData);
      } else if (rawData is Map<String, dynamic>) {
        parsedData = rawData;
      } else {
        throw AppException(ErrorMessages.unexpectedResponseFormat);
      }

      final apiResponse = ApiResponse.fromJson(parsedData);
      print(apiResponse.message);

      if (!apiResponse.isSuccess) {
        CustomSnackbar.fail(apiResponse.message);
      }else{
        if (!otpSent) otpSent = true;
        update();

        startResendTimer();
        CustomSnackbar.success(apiResponse.message);
      }

    } on AppException catch (e) {
      CustomSnackbar.fail(e.message);
    } catch (e) {
      CustomSnackbar.fail(e.toString());
      // CustomSnackbar.fail(ErrorMessages.unexpected);
      debugPrint('OTP request error: $e');
    } finally {
      CustomLoader.hide(context);
    }
  }

  void startResendTimer() {
    canResend = false;
    resendSeconds = 30;
    update();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds == 0) {
        timer.cancel();
        canResend = true;
        update();
      } else {
        resendSeconds--;
        update();
      }
    });
  }

  @override
  void onClose() {
    if (mobileController.hasListeners) mobileController.dispose();
    if (otpController.hasListeners) otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> initialize() async {
    version = await printAppVersion();
  }
}
