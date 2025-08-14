import 'package:get/get.dart';

class StatusController extends GetxController {
  var status = 'notStartedYet'.tr.obs;

  void setStatus(String newStatus) {
    status.value = newStatus;
  }

}
