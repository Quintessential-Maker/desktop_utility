
import 'package:dsc_utility/presentation/controller/certificate_list_controller.dart';
import 'package:dsc_utility/presentation/controller/choose_certificate_controller.dart';
import 'package:dsc_utility/presentation/controller/login_controller.dart';
import 'package:dsc_utility/presentation/controller/splash_controller.dart';
import 'package:dsc_utility/presentation/controller/xml_sign_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseCertificateController());
    Get.lazyPut(() => CertificateListController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => XmlSignController());
    Get.lazyPut(() => SplashController());
  }
}
