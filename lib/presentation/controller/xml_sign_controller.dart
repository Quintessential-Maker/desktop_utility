// lib/controllers/xml_sign_controller.dart
import 'package:dsc_utility/core/constants/custom_snackbar.dart';
import 'package:dsc_utility/core/error/app_exception.dart';
import 'package:dsc_utility/features/auth/data/data_sources/xmlsigning_remote_data_source.dart';
import 'package:dsc_utility/helper/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class XmlSignController extends GetxController {
  final Dio _dio = Dio();
  var signedXml = ''.obs;
  var isLoading = false.obs;
  var error = ''.obs;
  final _xmlRemoteDataSource = XmlSigningRemoteDataSource();

  Future<void> signXml(BuildContext context, String xmlString) async {
    CustomLoader.show(context);
    error.value = '';
    signedXml.value = '';

    try {
      final response = await _xmlRemoteDataSource.signXml(xmlString, '60000');

      print(response);

      signedXml.value = response.data;
      CustomSnackbar.success('XML signed successfully!');
    } on AppException catch (e) {
      error.value = e.message;
      CustomSnackbar.fail('Failed: ${e.message}');
    } catch (e) {
      error.value = 'Unexpected error: $e';
      CustomSnackbar.fail('Error: $e');
    } finally {
      CustomLoader.hide(context);
    }
  }


}
