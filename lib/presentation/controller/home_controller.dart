import 'package:dsc_utility/helper/custom_snackbar.dart';
import 'package:dsc_utility/core/error/app_exception.dart';
import 'package:dsc_utility/features/auth/data/data_sources/xmlsigning_remote_data_source.dart';
import 'package:dsc_utility/helper/custom_loader.dart';
import 'package:dsc_utility/presentation/widgets/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  var isRunning = false.obs;
  var isTestButtonClicked = false.obs;

  var status = 'notStartedYet'.tr.obs; // default
  var port = '60000'.obs;
  final statusController = Get.put(StatusController());
  var historyList = <Map<String, String>>[].obs;
final xmlInputController = TextEditingController(text: '<?xml version="1.0" encoding="UTF-8"?> <library> <book id="bk101"> <title>The Art of War</title> <author>Sun Tzu</author> <genre>Military Strategy</genre> <publication_year>500 BC</publication_year> <price>12.99</price> </book> <book id="bk102"> <title>Pride and Prejudice</title> <author>Jane Austen</author> <genre>Romance</genre> <publication_year>1813</publication_year> <price>9.50</price> </book> <magazine id="mg201"> <title>National Geographic</title> <issue>July 2025</issue> <publisher>National Geographic Society</publisher> </magazine> </library>');
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
    status.value = 'startedNIidle'.tr;
    statusController.status.value = status.value;
    // TODO: start socket logic
  }

  void stopSocket() {
    isRunning.value = false;
    status.value = 'stopped'.tr;
    isTestButtonClicked.value = false;
    statusController.status.value = status.value;
    // TODO: stop socket logic
  }

  void setBusy() {
    status.value = 'busy'.tr;
    statusController.status.value = status.value;
  }

  void setOops(String message) {
    error.value = message;
    status.value = 'oops'.tr;
    statusController.status.value = status.value;
  }

  void setCompleted() {
    status.value = 'completed'.tr;
    isTestButtonClicked.value = false;
    statusController.status.value = status.value;
    // after 30 seconds → available
    Future.delayed(Duration(seconds: 2), () {
      if (status.value == 'completed'.tr) {
        status.value = 'available'.tr;
        statusController.status.value = status.value;
      }
    });
  }

  void testSocket(BuildContext context) {
    if (isRunning.value) {
      //status.value = 'startedNIdle'.tr;
      statusController.status.value = status.value;
      isTestButtonClicked.value = true;
      // _showTestDialog(context);
    } else {
      // CustomSnackbar.oops('startServiceFirst'.tr);
      CustomSnackbarOverlay.show(
        context,
        title: "Oops",
        message: "Start service first",
        bgColor: Colors.orange,
        icon: Icons.error_outline,
      );
    }
  }

  void _showTestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * 0.8,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('testXml'.tr,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall),
                        SizedBox(height: 16),
                        TextFormField(
                          maxLines: 5,
                          // onChanged: (val) => xmlInputController.text = val,
                          controller: xmlInputController,
                          decoration: InputDecoration(
                            labelText: 'enterXml'.tr,
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
                            label: Text('send'.tr),
                          ),
                        ),
                      ],
                    ),
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
  }

  Future<void> signXml(BuildContext context) async {
    final input = xmlInputController.text.trim();
    final port = portController.text.trim();
    final requestTime = DateTime.now().toIso8601String();

    if (input.isEmpty) {
      CustomSnackbar.fail('enterXmlMsg'.tr);
      _addHistory(
        reqTS: requestTime,
        url: 'N/A',
        authToken: 'N/A',
        repliedTS: DateTime.now().toIso8601String(),
        statusCode: 'Input Missing',
      );
      return;
    }
    if (!input.startsWith('<') || !input.endsWith('>') || !input.contains('</')) {
      CustomSnackbar.fail('invalidXml'.tr);
      _addHistory(
        reqTS: requestTime,
        url: 'N/A',
        authToken: 'N/A',
        repliedTS: DateTime.now().toIso8601String(),
        statusCode: 'Invalid XML',
      );
      return;
    }

    setBusy();
    CustomLoader.show(context);
    error.value = '';
    signedXml.value = '';

    try {
      final response = await _xmlRemoteDataSource.signXml(input, port);
      signedXml.value = response.data;
      status.value = 'completed'.tr;
      statusController.status.value = status.value;
      setCompleted();

      _addHistory(
        reqTS: requestTime,
        url: 'http://localhost:$port/signxml',
        authToken: 'N/A', // अगर token हो तो यहां डालना
        repliedTS: DateTime.now().toIso8601String(),
        statusCode: '${response.statusCode}',
      );

      CustomSnackbar.success('xmlSigned'.tr);
      // Navigator.of(context).pop();
    } on AppException catch (e) {
      setOops(e.message);
      _addHistory(
        reqTS: requestTime,
        url: 'http://localhost:$port/signxml',
        authToken: 'N/A',
        repliedTS: DateTime.now().toIso8601String(),
        statusCode: 'Oops:\n${e.message}',
      );
    } catch (e) {
      setOops(e.toString());
      _addHistory(
        reqTS: requestTime,
        url: 'http://localhost:$port/signxml',
        authToken: 'N/A',
        repliedTS: DateTime.now().toIso8601String(),
        statusCode: 'Error:\n$e',
      );
    } finally {
      CustomLoader.hide(context);
    }
  }

  void _addHistory({
    required String reqTS,
    required String url,
    required String authToken,
    required String repliedTS,
    required String statusCode,
  }) {
    historyList.add({
      'reqTS': reqTS,
      'url': url,
      'authToken': authToken,
      'repliedTS': repliedTS,
      'statusCode': statusCode,
    });
  }

}
