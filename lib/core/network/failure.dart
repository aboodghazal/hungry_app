import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets/assets.gen.dart';

/// الأساس لجميع أنواع الأخطاء
abstract class Failure implements Exception {
  final String message;
  final Map<String, dynamic> fields;
  final int statusCode;
  final SvgPicture? icon;

  Failure({
    required this.message,
    required this.fields,
    required this.statusCode,
    this.icon,
  });

  @override
  String toString() {
    return 'Failure: $message (status: $statusCode, fields: $fields)';
  }

  Map<String, dynamic> toMap() => {
    'message': message,
    'fields': fields,
    'statusCode': statusCode,
  };
}

/// خطأ قادم من السيرفر (Dio أو استجابة HTTP)
class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.fields,
    required super.statusCode,
    super.icon,
  });

  /// التعامل مع DioException
  factory ServerFailure.fromDioError(DioException e) {
    final errorIcon = Assets.icon.error.svg(height: 70.h, width: 70.w);
    final noInternetIcon = Assets.icon.error.svg(height: 70.h, width: 70.w);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message: 'Connection timed out',
          fields: {},
          statusCode: e.response?.statusCode ?? 500,
          icon: errorIcon,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: 'Send request timed out',
          fields: {},
          statusCode: e.response?.statusCode ?? 500,
          icon: errorIcon,
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: 'Receive response timed out',
          fields: {},
          statusCode: e.response?.statusCode ?? 500,
          icon: errorIcon,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          message: 'Bad SSL certificate',
          fields: {},
          statusCode: e.response?.statusCode ?? 500,
          icon: errorIcon,
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response?.statusCode ?? 500,
          e.response?.data ?? {},
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'Request was cancelled',
          fields: {},
          statusCode: e.response?.statusCode ?? 500,
          icon: errorIcon,
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          message: 'No internet connection',
          fields: {},
          statusCode: e.response?.statusCode ?? 0,
          icon: noInternetIcon,
        );

      case DioExceptionType.unknown:
        return ServerFailure.fromResponse(
          e.response?.statusCode ?? 500,
          e.response?.data ?? {'message': 'Unknown error'},
        );
    }
  }

  /// تحليل الرد القادم من السيرفر
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    final errorIcon = Assets.icon.error.svg(height: 70.h, width: 70.w);

    // قراءة الرسالة من الرد
    String message = response['message']?.toString() ?? 'Unknown error';

    // قراءة الأخطاء الحقلية (مثل email)
    Map<String, dynamic> fields = {};
    if (response['errors'] is Map<String, dynamic>) {
      fields = response['errors'];
    }

    // تحديد الرسالة العامة بناءً على كود الحالة
    switch (statusCode) {
      case 400:
        message = 'Bad request';
        break;
      case 401:
        message = 'Unauthorized access';
        break;
      case 403:
        message = 'Forbidden';
        break;
      case 404:
        message = 'Error 404 - Resource not found';
        break;
      case 422:
        message = response['message'] ?? 'Validation error';
        break;
      case 429:
        message = 'Too many requests. Please try again later.';
        break;
      case 500:
        message = 'Internal server error';
        break;
      default:
        message = response['message'] ?? 'Unexpected error occurred';
    }

    return ServerFailure(
      statusCode: statusCode,
      message: message,
      fields: fields,
      icon: errorIcon,
    );
  }
}
