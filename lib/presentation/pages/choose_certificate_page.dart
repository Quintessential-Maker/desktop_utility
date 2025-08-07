import 'package:dsc_utility/presentation/controller/choose_certificate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseCertificatePage extends StatelessWidget {
  final ChooseCertificateController controller = Get.put(ChooseCertificateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Windows Certificates')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: controller.openWindowsCertificateManager,
              child: Text('Open Certificate Manager'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.listUserCertificates,
              child: Text('List Certificates'),
            ),
            SizedBox(height: 20),
            Obx(() => Expanded(
              child: SingleChildScrollView(
                child: Text(controller.certificateOutput.value),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

