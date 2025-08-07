class InputValidator {
  static String? validateMobile(String mobile) {
    if (mobile.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (mobile.trim().length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile.trim())) {
      return 'Please enter a valid mobile number';
    }
    return null; // valid
  }

  static String? validateOtp(String otp) {
    if (otp.trim().isEmpty) {
      return 'OTP is required';
    }
    if (otp.length != 6) {
      return 'OTP must be 6 digits';
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(otp.trim())) {
      return 'Please enter a valid OTP';
    }
    return null;
  }

  // 🔄 Add more validations below as needed
  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}