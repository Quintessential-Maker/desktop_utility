class ApiEnvironment {
  static const bool isProduction = true; // Toggle for environment

  static String get baseUri => isProduction ? 'www.pmposhan.mp.gov.in' : '10.131.11.104';

  static String get baseUrl => 'https://$baseUri';
  // static String get baseUrlForSigning => 'http://localhost:60000'; //localhost:59596
  static String baseUrlForSigning(String port) => 'http://localhost:$port';
}

class ApiPath {
  static const String inspectionService = 'Inspections/Services/Insp5ct0rServi35.svc';
  static const String mealService = 's3rvic3s/api/meal';
// Add more base paths as needed
}

class ApiEndpoints {
  // Auth
  static String get requestOtp => '${ApiEnvironment.baseUrl}/${ApiPath.inspectionService}/ReQuestOTPv6';
  static String get verifyOtp => '${ApiEnvironment.baseUrl}/${ApiPath.inspectionService}/VerifyOTPv9';

  // Meals
  static String get mealDiary => '${ApiEnvironment.baseUrl}/${ApiPath.mealService}/Diary';

  // XML Signing
  // static String get signXml => '${ApiEnvironment.baseUrlForSigning}/signxml';
  static String signXml(String port) => '${ApiEnvironment.baseUrlForSigning(port)}/signxml';

  // Static pages
  static String get privacyPolicy => '${ApiEnvironment.baseUrl}/PrivacyPolicy.aspx';
  static String get forgotPassword => '${ApiEnvironment.baseUrl}/Login/Pages/RequestPin.aspx';

// Add more endpoints as needed in similar style
}