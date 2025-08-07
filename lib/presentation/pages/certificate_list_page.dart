import 'package:dsc_utility/presentation/controller/certificate_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CertificateListPage extends StatelessWidget {
  const CertificateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CertificateListController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('DSC Utility'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Certificates'),
              /*Tab(text: 'COM Ports'),*/
              Tab(text: 'TCP Ports'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.loading.value) {
              return Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                controller.buildCertificatesTab(),
                controller.buildTcpPortsTab(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
