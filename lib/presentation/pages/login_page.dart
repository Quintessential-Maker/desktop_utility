
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/dance_image.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:dsc_utility/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class DesktopLoginPage extends StatelessWidget {
  const DesktopLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Row(
                children: [
                  if (isWide)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: HoverDanceImage(),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Madhya Pradesh PM Poshan Shakti Nirman Yojana',
                                  textAlign: TextAlign.center,
                                  style: themeVariable.titleStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: hexToColor(CustomColors.dangerColorBg),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text('Welcome Back! 👋', style: themeVariable.titleStyle),
                              const SizedBox(height: 8),
                              Text('Please login to your account', style: themeVariable.subTitleStyle),
                              const SizedBox(height: 24),

                              // 👉 Mobile Number
                              TextField(
                                controller: controller.mobileController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // 👉 OTP Field
                              if (controller.otpSent)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: PinCodeTextField(
                                    length: 6,
                                    appContext: context,
                                    keyboardType: TextInputType.number,
                                    animationType: AnimationType.fade,
                                    controller: controller.otpController,
                                    onChanged: (_) {},
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(10),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeColor: hexToColor(CustomColors.primaryColor),
                                      inactiveColor: Colors.grey.shade400,
                                      selectedColor: hexToColor(CustomColors.primaryColor),
                                      activeFillColor: Colors.white,
                                      inactiveFillColor: Colors.white,
                                      selectedFillColor: Colors.white,
                                    ),
                                    animationDuration: const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                  ),
                                ),

                              const SizedBox(height: 16),

                              // 👉 Resend Button (with timer)
                              if (controller.otpSent)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: controller.canResend
                                        ? () => controller.requestOTP(context)
                                        : null,
                                    child: Text(
                                      controller.canResend
                                          ? 'Resend OTP'
                                          : 'Resend OTP in ${controller.resendSeconds}s',
                                      style: themeVariable.subTitleStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 16),

                              // 👉 Send OTP / Verify OTP Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: hexToColor(CustomColors.primaryColor),
                                    foregroundColor: hexToColor(CustomColors.whiteColor),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: controller.otpSent
                                      ? () => controller.verifyOtpAndLogin(context)
                                      : () => controller.requestOTP(context),
                                  child: Text(controller.otpSent ? 'Verify OTP' : 'Send OTP'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
