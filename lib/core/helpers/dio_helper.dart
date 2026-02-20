import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';


import '../../shared/session_expired_dialog.dart';
import '../cached/app_controller.dart';
import '../constants/api_endpoints.dart';
import '../constants/const_string.dart';
import '../network/failure.dart';
import '../routes/go_routes.dart';
import 'helper_function.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30), // مهلة الاتصال 30 ثانية
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          /*'Accept-Language': AppController.instance.getLanguageCode(),*/
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Platform': Platform.isAndroid ? 'android' : 'ios',
        },
      ),
    );

    dio!.interceptors.add(LogInterceptor(responseBody: true));
    dio!.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
  }

  /// Save data to cache
  static Future<void> _saveCache(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  /// Retrieve data from cache
  static Future<Map<String, dynamic>?> _getCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(key);
    if (jsonData != null) {
      return jsonDecode(jsonData) as Map<String, dynamic>;
    }
    return null;
  }

  /// GET request with offline/timeout cache support
  static Future<Response> getData({
    String? url,
    String? fullUrl,
    Map<String, dynamic>? query,
    bool useCache = true,
  }) async {
    final String token = await AppController.getSecuredString(tokenText);
     dio!.options.headers = _buildHeaders(token);

    final bool isExternal = fullUrl != null;
    final String requestUrl = isExternal ? fullUrl : (baseUrl + url!);

    try {
      final response = await dio!.get(requestUrl, queryParameters: query);
      if (useCache && !isExternal) await _saveCache(url!, response.data);
      return response;
    } on DioException catch (e) {
      return await _handleOfflineOrTimeoutFallback(e, url ?? fullUrl ?? '');
    }
  }

  /// POST request with offline/timeout cache support
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    bool needFormData = true,
    bool useCache = false,
  }) async {
    final String? token = await AppController.getSecuredString(tokenText);
    dio!.options.headers = _buildHeaders(token ?? '');

    try {
      var dataToSend = needFormData ? FormData.fromMap(body ?? {}) : body;
      Response response = await dio!.post(
        url,
        data: dataToSend,
        queryParameters: query,
      );
      if (useCache) await _saveCache(url, response.data);
      return response;
    } on DioException catch (e) {
      return await _handleOfflineOrTimeoutFallback(e, url);
    }
  }

  /// PATCH request with offline/timeout cache support
  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    bool needFormData = true,
    bool useCache = false,
  }) async {
    final String token = await AppController.getSecuredString(tokenText);
    dio!.options.headers = _buildHeaders(token);

    try {
      var dataToSend = needFormData ? FormData.fromMap(body ?? {}) : body;
      Response response = await dio!.patch(
        url,
        data: dataToSend,
        queryParameters: query,
      );
      if (useCache) await _saveCache(url, response.data);
      return response;
    } on DioException catch (e) {
      return await _handleOfflineOrTimeoutFallback(e, url);
    }
  }

  /// PUT request with offline/timeout cache support
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    bool needFormData = true,
    bool useCache = true,
  }) async {
    final String token = await AppController.getSecuredString(tokenText);
    dio!.options.headers = _buildHeaders(token);

    try {
      var formData = needFormData ? FormData.fromMap(data ?? {}) : data;
      Response response = await dio!.put(
        url,
        data: formData,
        queryParameters: query,
      );
      if (useCache) await _saveCache(url, response.data);
      return response;
    } on DioException catch (e) {
      return await _handleOfflineOrTimeoutFallback(e, url);
    }
  }

  /// DELETE request with offline/timeout cache support
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    bool useCache = true,
  }) async {
    final String token = await AppController.getSecuredString(tokenText);
    dio!.options.headers = _buildHeaders(token);

    try {
      Response response = await dio!.delete(url, queryParameters: query);
      if (useCache) await _saveCache(url, response.data);
      return response;
    } on DioException catch (e) {
      return await _handleOfflineOrTimeoutFallback(e, url);
    }
  }

  /// Build headers
  static Map<String, String> _buildHeaders(String token) {
    return {
      if (token.trim().isNotEmpty)
        'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
/*
      'Accept-Language': AppController.instance.getLanguageCode(),
*/
      'Accept': 'application/json',
      'User-Platform': Platform.isAndroid ? 'android' : 'ios',
    };
  }

  /// File upload with timeout/offline cache support
  static Future<String> uploadFile({
    required String url,
    required Function(int progress) onProgress,
    bool useCache = true,
  }) async {
    try {
      final String token = await AppController.getSecuredString(tokenText);
      dio!.options.headers = {
        if (token.trim().isNotEmpty) 'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
/*
        'Accept-Language': AppController.instance.getLanguageCode(),
*/
        'User-Platform': Platform.isAndroid ? 'android' : 'ios',
      };

      final file = await MultipartFile.fromFile(url, filename: url);
      var formData = FormData.fromMap({'file': file});

      final response = await dio!.post(
        uploadFileEndPoint,
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0) {
            int progressValue = ((sent / total) * 100).toInt();
            onProgress(progressValue);
          }
        },
      );

      if (useCache) await _saveCache(uploadFileEndPoint, response.data);

      return response.data['file_path'] ?? '';
    } on DioException catch (e) {
      // Try from cache on timeout or offline
      if (_isTimeoutOrNoInternet(e)) {
        final cachedData = await _getCache(uploadFileEndPoint);
        if (cachedData != null) {
          return cachedData['file_path'] ?? '';
        }
      }
      if (e.response?.statusCode == 401) _handleTokenExpiry();
      _logDioError(e);
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(
        message: e.toString(),
        fields: {},
        statusCode: e.hashCode,
      );
    }
  }

  /// Handle offline or timeout fallback from cache
  static Future<Response> _handleOfflineOrTimeoutFallback(
    DioException e,
    String url,
  ) async {
    if (_isTimeoutOrNoInternet(e)) {
      log("No internet or timeout, loading from cache for: $url");
      final cachedData = await _getCache(url);
      if (cachedData != null) {
        return Response(
          requestOptions: RequestOptions(path: url),
          data: cachedData,
          statusCode: 200,
        );
      }
    }

    if (e.response?.statusCode == 401) _handleTokenExpiry();

    _logDioError(e);
    throw e;
  }

  /// Check if error is timeout or no internet
  static bool _isTimeoutOrNoInternet(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.error is SocketException;
  }

  /// Token expiry handler
  static void _handleTokenExpiry() {
    final BuildContext? context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SessionExpiredDialog(
            title: 'S.of(context).sessionExpire',
            content: 'S.of(context).pleaseLogin',
            onLogout: () => logoutFunction(context),
          );
        },
      );
    }
  }

  /// Logging errors
  static void _logDioError(DioException exception) {
    log('DioError: ${exception.message}');
    if (exception.response != null) {
      log('Response data: ${exception.response?.data}');
      log('Response status: ${exception.response?.statusCode}');
    }
  }
}
