import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsc_utility/core/constants/api_constants.dart';
import 'package:dsc_utility/core/constants/preferences.dart';
import 'package:dsc_utility/core/network/remote_data_source_base.dart';
import 'package:dsc_utility/helper/custom_loader.dart';
import 'package:dsc_utility/helper/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class XmlSigningRemoteDataSource extends RemoteDataSourceBase {

  Future<Response> signXml(String xmlString, String port) async {

    return await post(
      ApiEndpoints.signXml(port),
      data: xmlString,
    );
  }
}

