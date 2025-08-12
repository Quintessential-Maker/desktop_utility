import 'package:dsc_utility/core/constants/custom_snackbar.dart';
import 'package:dsc_utility/core/error/app_exception.dart';
import 'package:dsc_utility/features/auth/data/data_sources/xmlsigning_remote_data_source.dart';
import 'package:dsc_utility/helper/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class HomeViewController extends GetxController {
  var isRunning = false.obs;
  var status = 'Idle'.obs;
  var port = '60000'.obs;

  var xmlInput = ''.obs;
  var historyList = <Map<String, String>>[].obs;

  final portController = TextEditingController();

  var signedXml = ''.obs;
  final _xmlRemoteDataSource = XmlSigningRemoteDataSource();
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    portController.text = port.value;
    portController.addListener(() {
      port.value = portController.text;
    });
  }

  void startSocket() {
    isRunning.value = true;
    status.value = 'Busy';
    // TODO: start socket logic
  }

  void stopSocket() {
    isRunning.value = false;
    status.value = 'Idle';
    // TODO: stop socket logic
  }

  void testSocket(BuildContext context) {
    if(isRunning.value){
      showDialog(
        context: context,
        barrierDismissible: false, // prevents background interaction
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth * 0.8, // responsive
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Test XML Input",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            maxLines: 5,
                            onChanged: (val) => Get.find<HomeViewController>().xmlInput.value = val,
                            decoration: InputDecoration(
                              labelText: 'Enter XML',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await signXml(context);
                              },
                              icon: Icon(Icons.send),
                              label: Text('Send'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// Close Button (Top Right)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }else{
      CustomSnackbar.oops('Start service first');
    }

    }

  Future<void> signXml(BuildContext context) async {
    final input = xmlInput.value.trim();
    final port = portController.text.trim();
    final requestTime = DateTime.now().toIso8601String();

    if (input.isEmpty) {
      CustomSnackbar.fail('Please enter XML input.');
      return;
    }

    if (!input.startsWith('<') || !input.endsWith('>') || !input.contains('</')) {
      CustomSnackbar.fail('Invalid XML format.');
      return;
    }

    status.value = 'Busy';
    CustomLoader.show(context);
    error.value = '';
    signedXml.value = '';

    try {
      final response = await _xmlRemoteDataSource.signXml(input, port);
      final responseXml = response.data;
      signedXml.value = responseXml;

      try {
        final document = XmlDocument.parse(responseXml);

        final signatureValue =
            document.findAllElements('SignatureValue').firstOrNull?.text ?? 'N/A';
        final to = document.findAllElements('To').firstOrNull?.text ?? 'Unknown';
        final from = document.findAllElements('From').firstOrNull?.text ?? 'Unknown';

        // ✅ Add success entry to history
        historyList.add({
          'RequestTS': requestTime,
          'URL': 'From: $from → To: $to',
          'AuthToken': signatureValue.length > 20
              ? '${signatureValue.substring(0, 20)}...'
              : signatureValue,
          'RepliedTS': DateTime.now().toIso8601String(),
          'StatusCode': '${response.statusCode}',
        });

        status.value = 'Idle';
        CustomSnackbar.success('XML signed successfully!');
        Navigator.of(context).pop(); // Close on success only
      } catch (e) {
        // ❌ Invalid XML received
        historyList.add({
          'RequestTS': requestTime,
          'URL': 'Unknown (invalid XML)',
          'AuthToken': 'Invalid',
          'RepliedTS': DateTime.now().toIso8601String(),
          'StatusCode': 'Error',
        });

        status.value = 'Oops';
        error.value = 'Invalid signed XML: $e';
        CustomSnackbar.fail('Signing failed: Invalid XML format.\n$e');
      }
    } on AppException catch (e) {
      // ❌ Application-level failure
      historyList.add({
        'RequestTS': requestTime,
        'URL': 'Unknown (AppException)',
        'AuthToken': 'N/A',
        'RepliedTS': DateTime.now().toIso8601String(),
        'StatusCode': 'Error',
      });

      error.value = e.message;
      status.value = 'Oops';
      CustomSnackbar.fail('Failed: ${e.message}');
    } catch (e) {
      // ❌ Generic error
      historyList.add({
        'RequestTS': requestTime,
        'URL': 'Unknown (exception)',
        'AuthToken': 'N/A',
        'RepliedTS': DateTime.now().toIso8601String(),
        'StatusCode': 'Error',
      });

      status.value = 'Oops';
      error.value = 'Unexpected error: $e';
      CustomSnackbar.fail('Error: $e');
    } finally {
      CustomLoader.hide(context);
    }
  }


}
