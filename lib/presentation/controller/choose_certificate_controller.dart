import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChooseCertificateController extends GetxController {
  RxString certificateOutput = ''.obs;

  void openWindowsCertificateManager() {
    if (Platform.isWindows) {
      Process.run('powershell', [
        '-Command',
        r'$cert = Get-ChildItem -Path Cert:\CurrentUser\My | Out-GridView -Title "Select a Certificate" -PassThru; if ($cert) {Write-Host $cert.Subject}'
      ]).catchError((e) {
        debugPrint('Error: $e');
      });
    }
  }

  void listUserCertificates() async {
    if (Platform.isWindows) {
      try {
        final result = await Process.run(
          'powershell',
          [
            '-Command',
            '''
            Get-ChildItem -Path Cert:\\CurrentUser\\My | 
            Select-Object Subject, Issuer, Thumbprint, FriendlyName, NotBefore, NotAfter, HasPrivateKey | 
            Format-List
            '''
          ],
          runInShell: true,
        );
        certificateOutput.value = result.stdout.toString();
      } catch (e) {
        certificateOutput.value = 'Error: $e';
      }
    } else {
      certificateOutput.value = 'Only supported on Windows';
    }
  }

  Future<void> sendXmlToSigner(String xmlData) async {
    final url = Uri.parse('http://localhost:59596/signxml');

    try {
      final response = await HttpClient().postUrl(url).then((req) {
        req.headers.set('Content-Type', 'application/xml');
        req.write(xmlData);
        return req.close();
      });

      if (response.statusCode == 200) {
        final responseBody = await response.transform(SystemEncoding().decoder).join();
        debugPrint("Signed XML received:\n$responseBody");
      } else {
        debugPrint("Error ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
    }
  }
}

