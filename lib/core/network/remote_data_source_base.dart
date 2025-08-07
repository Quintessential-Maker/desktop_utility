// lib/core/network/remote_data_source_base.dart
import 'package:dio/dio.dart';
import 'package:dsc_utility/core/constants/dio_client.dart';
import 'package:dsc_utility/core/constants/error_messages.dart';
import 'package:dsc_utility/core/error/app_exception.dart';

abstract class RemoteDataSourceBase {
  final Dio _dio = DioClient.instance;

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      throw AppException(_handleDioError(e));
    } catch (_) {
      throw AppException(ErrorMessages.unexpected);
    }
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      print(endpoint);
      final response = await _dio.post(endpoint, data: data, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      throw AppException(_handleDioError(e));
    } catch (_) {
      throw AppException(ErrorMessages.unexpected);
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorMessages.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return ErrorMessages.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.receiveTimeout;
      case DioExceptionType.badResponse:
        return ErrorMessages.badResponse;
      case DioExceptionType.cancel:
        return ErrorMessages.requestCancelled;
      default:
        return ErrorMessages.unexpected;
    }
  }
}
