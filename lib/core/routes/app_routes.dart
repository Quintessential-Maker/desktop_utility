import 'package:dsc_utility/presentation/controller/certificate_list_controller.dart';
import 'package:dsc_utility/presentation/controller/choose_certificate_controller.dart';
import 'package:dsc_utility/presentation/controller/home_controller.dart';
import 'package:dsc_utility/presentation/controller/login_controller.dart';
import 'package:dsc_utility/presentation/controller/splash_controller.dart';
import 'package:dsc_utility/presentation/controller/xml_sign_controller.dart';
import 'package:dsc_utility/presentation/pages/certificate_list_page.dart';
import 'package:dsc_utility/presentation/pages/choose_certificate_page.dart';
import 'package:dsc_utility/presentation/pages/home_view.dart';
import 'package:dsc_utility/presentation/pages/login_page.dart';
import 'package:dsc_utility/presentation/pages/splash_view.dart';
import 'package:dsc_utility/presentation/pages/xml_sign_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String chooseCertificate = '/chooseCertificate';
  static const String certificateList = '/certificateList';
  // static const String xmlSignView = '/xmlSignView';
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginPage(),binding: BindingsBuilder(() { Get.put(LoginController()); }),),
    GetPage(name: AppRoutes.home, page: () =>  HomeViewPage(),binding: BindingsBuilder(() { Get.put(HomeViewController()); }),),
    GetPage(name: AppRoutes.certificateList, page: () => const CertificateListPage(),binding: BindingsBuilder(() { Get.put(CertificateListController()); }),),
    GetPage(name: AppRoutes.chooseCertificate, page: () => ChooseCertificatePage(),binding: BindingsBuilder(() { Get.put(ChooseCertificateController()); }),),
    // GetPage(name: AppRoutes.xmlSignView, page: () => XmlSignViewPage(),binding: BindingsBuilder(() { Get.put(XmlSignController()); }),),
    GetPage(name: AppRoutes.splash, page: () => const SplashView(),binding: BindingsBuilder(() { Get.put(SplashController()); }),),
  ];
}