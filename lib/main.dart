import 'dart:io';
import 'package:dsc_utility/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(CertViewerApp());
}

class CertViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Certificate Viewer',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
