// lib/views/xml_sign_view.dart
import 'package:dsc_utility/presentation/controller/xml_sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XmlSignViewPage extends StatefulWidget {
  const XmlSignViewPage({super.key});

  @override
  State<XmlSignViewPage> createState() => _XmlSignViewPageState();
}

class _XmlSignViewPageState extends State<XmlSignViewPage> {
  final controller = Get.put(XmlSignController());
  final TextEditingController xmlInputController = TextEditingController();

  @override
  void dispose() {
    xmlInputController.dispose(); // ✅ controller properly disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('XML Signer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextField(
                controller: xmlInputController,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter XML here',
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  xmlInputController.text =
                  '<note><to>User</to><from>AI</from><body>Hello</body></note>';
                  controller.signXml(
                      context, xmlInputController.text.trim());
                },
                child: const Text('Sign XML'),
              )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.error.isNotEmpty) {
                  return Text(
                    controller.error.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                if (controller.signedXml.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        controller.signedXml.value,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

