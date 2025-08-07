// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEnvironment.baseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      contentType: 'application/json',
    ),
  );

  static Dio get instance => _dio;
}
