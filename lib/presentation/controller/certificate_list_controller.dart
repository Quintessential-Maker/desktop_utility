import 'package:dsc_utility/core/utils/certificate_service.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:dsc_utility/helper/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../data/repositories/dsc_repository_impl.dart';

class CertificateListController extends GetxController {
  final repo = DSCRepositoryImpl();

  var status = ''.obs;
  final MethodChannel channel = const MethodChannel('signing_channel');
  final certs = <Map<String, dynamic>>[].obs;
  final comPorts = <String>[].obs;
  final tcpPorts = <int>[].obs;
  var loading = true.obs;

@override
  void onInit() {
  fetchCertificates();
    super.onInit();
  }

  void fetchCertificates() async {
    try {
      final result = await getSystemInfo();

      final certsList = List<Map<String, dynamic>>.from(result['certificates'] ?? []);
      final coms = List<String>.from(result['comPorts'] ?? []);
      final tcps = List<int>.from(result['availableTcpPorts'] ?? []);

      // Unique certs
      final unique = <String, Map<String, dynamic>>{};
      for (var cert in certsList) {
        final thumbprint = cert['Thumbprint'];
        if (thumbprint != null) {
          unique[thumbprint] = cert;
        }
      }

      this.certs.value = unique.values.toList();
      this.comPorts.value = coms;
      this.tcpPorts.value = tcps;

    } catch (e) {
      Get.snackbar('Error', 'Could not load data');
    } finally {
      loading.value = false;
    }
  }

  void detectToken() async {
    status.value = "Detecting token...";
    final result = await repo.detectToken();
    status.value = result;
  }

  void signButtonPressed(String thumbprint) async {
    final xmlPath = await prepareXmlFile();
    await signXml(xmlPath, thumbprint);
  }

  Widget buildCertificatesTab() {
    if (certs.isEmpty) {
      return Center(child: Text('No certificates found'));
    }

    return ListView.builder(
      itemCount: certs.length,
      itemBuilder: (context, index) {
        final cert = certs[index];
        final backgroundColor = index % 2 == 0
            ? hexToColor(CustomColors.primaryColor)
            : hexToColor(CustomColors.secondaryColor);

        return InkWell(
          onTap: () {
            final selectedThumbprint = cert['Thumbprint'];
            Get.snackbar('Certificate Selected', selectedThumbprint);
            signButtonPressed(selectedThumbprint);

          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.badge, size: 40, color: Colors.black87),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getCommonName(cert['Subject']),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Issuer: ${getCommonName(cert['Issuer'])}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Valid From: ${cert['NotBefore']} to ${cert['NotAfter']}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(
                  cert['HasPrivateKey'] ? Icons.vpn_key : Icons.lock,
                  color: cert['HasPrivateKey'] ? Colors.green : Colors.red,
                  size: 28,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* Widget _buildComPortsTab() {
    if (controller.comPorts.isEmpty) {
      return Center(child: Text('No COM ports found'));
    }

    return ListView.builder(
      itemCount: controller.comPorts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.usb),
          title: Text(controller.comPorts[index]),
        );
      },
    );
  }*/

  Widget buildTcpPortsTab() {
    if (tcpPorts.isEmpty) {
      return Center(child: Text('No available TCP ports'));
    }

    return ListView.builder(
      itemCount: tcpPorts.length,
      itemBuilder: (context, index) {
        final backgroundColor = index % 2 == 0
            ? hexToColor(CustomColors.primaryColor)
            : hexToColor(CustomColors.secondaryColor);
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.09),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(Icons.network_check),
            title: Text('Port ${tcpPorts[index]}'),
          ),
        );
      },
    );
  }

  String getCommonName(String? dn) {
    if (dn == null) return '';
    final match = RegExp(r'CN=([^,]+)').firstMatch(dn);
    return match != null ? match.group(1)! : dn;
  }
}
