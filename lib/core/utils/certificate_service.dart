import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/*Future<List<Map<String, dynamic>>> getInstalledCertificates() async {
  // final exePath = 'assets/windows_tools/CertLister.exe'; // Change path if needed
  final exePath = r'D:\WORKSPACES\FLUTTER\Sample\dsc_utility_app\assets\windows_tools\CertLister.exe';


  try {
    final result = await Process.run(exePath, [], runInShell: true);

    if (result.exitCode == 0) {
      final output = result.stdout;
      final certs = jsonDecode(output);
      return List<Map<String, dynamic>>.from(certs);
    } else {
      throw Exception('EXE failed: ${result.stderr}');
    }
  } catch (e) {
    print('Error running EXE: $e');
    rethrow;
  }
}*/

Future<Map<String, dynamic>> getSystemInfo() async {
  final exePath = r'D:\WORKSPACES\FLUTTER\Sample\dsc_utility_app\assets\windows_tools\CertLister.exe';

  try {
    final result = await Process.run(exePath, [], runInShell: true);

    if (result.exitCode == 0) {
      final output = result.stdout;
      final data = jsonDecode(output);

      return Map<String, dynamic>.from(data); // Now full JSON object
    } else {
      throw Exception('EXE failed: ${result.stderr}');
    }
  } catch (e) {
    print('Error running EXE: $e');
    rethrow;
  }
}

Future<String> prepareXmlFile() async {
  final bytes = await rootBundle.load('assets/images/sample.xml');

  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/sample.xml');

  await tempFile.writeAsBytes(bytes.buffer.asUint8List());

  return tempFile.path;
}

Future<void> signXml(String xmlPath, String thumbprint) async {
  final exePath = r'D:\WORKSPACES\FLUTTER\Sample\dsc_utility_app\assets\windows_tools\SignXmlApp.exe';

  final result = await Process.run(
    exePath,
    [xmlPath, thumbprint], // arguments
    runInShell: true,
  );

  if (result.stdout.toString().contains('VALID')) {
    // Get.snackbar('OK', 'XML signature verified!');
    print('XML signature verified!');
  } else {
    // Get.snackbar('Error', 'XML signature is invalid.');
    print('XML signature is invalid!');
  }

  if (result.exitCode == 0) {
    print("Signed XML output:\n${result.stdout}");
    Get.snackbar('Success', 'XML signed successfully!');
  } else {
    print("Error:\n${result.stderr}");
    Get.snackbar('Error', 'Failed to sign XML');
  }
}