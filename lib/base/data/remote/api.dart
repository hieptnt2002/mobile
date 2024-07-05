import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:http/http.dart' as http;
import 'package:make_appointment_app/app/environment.dart';
import 'package:make_appointment_app/base/data/remote/meta_response.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';

enum HttpMethod { get, put, patch, post, delete }

class Api {
  static const timeout = Duration(seconds: 30);

  static Future<Map<String, String>> _createHeader(
    Map<String, String> defaultHeader,
  ) async {
    final token = locator.get<SharedPreferencesService>().getToken();
    final locale = locator.get<SharedPreferencesService>().getLocale();
    var headers = {'Content-Type': 'application/json'};
    headers = {...headers, ...defaultHeader};
    headers['language'] = locale;
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static Future<dynamic> request({
    required HttpMethod httpMethod,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> body = const {},
    Map<String, String> header = const {},
  }) async {
    http.Response? response;
    var headers = await _createHeader(header);
    final uri = Uri(
      scheme: Environment.apiScheme,
      port: Environment.apiPort,
      host: Environment.apiHost,
      path: Environment.apiPrefix + url,
      queryParameters: queryParameters,
    );

    switch (httpMethod) {
      case HttpMethod.post:
        response = await http
            .post(uri, headers: headers, body: jsonEncode(body))
            .timeout(timeout, onTimeout: () => http.Response('Error', 504));
        break;
      case HttpMethod.put:
        response = await http
            .put(uri, headers: headers, body: jsonEncode(body))
            .timeout(timeout, onTimeout: () => http.Response('Error', 504));
        break;
      case HttpMethod.patch:
        response = await http
            .patch(uri, headers: headers, body: jsonEncode(body))
            .timeout(timeout, onTimeout: () => http.Response('Error', 504));
        break;
      case HttpMethod.delete:
        response = await http
            .delete(uri, headers: headers, body: jsonEncode(body))
            .timeout(timeout, onTimeout: () => http.Response('Error', 504));
        break;
      default:
        response = await http
            .get(uri, headers: headers)
            .timeout(timeout, onTimeout: () => http.Response('Error', 504));
    }
    final isSuccess = response.statusCode >= 200 && response.statusCode <= 299;
    final responseBody = jsonDecode(response.body);
    final baseApiResponse = BaseApiResponse.fromJson(responseBody);
    final responseMessage = baseApiResponse.meta.message;
    final responseErrors = baseApiResponse.meta.errors;

    debugPrint('\n\n=============/ API REQUEST /==============');
    debugPrint('PATH: ${uri.path}');
    debugPrint('METHOD: $httpMethod');
    debugPrint('CODE: ${response.statusCode}');
    debugPrint('RESPONSE BODY: ${response.body}');
    debugPrint('REQUEST BODY: $body');
    debugPrint('HEADER: $headers');
    debugPrint('=============/ =========== /==============\n\n');
    if (isSuccess) {
      return baseApiResponse.data;
    }
    switch (response.statusCode) {
      case 401:
        throw ApiException(
          type: ApiExceptionType.tokenExpires,
          code: response.statusCode,
          message: responseMessage,
          error: responseErrors,
        );
      case 504:
        throw ApiException(
          type: ApiExceptionType.timeout,
          code: response.statusCode,
          message: responseMessage,
          error: responseErrors,
        );
      default:
        throw ApiException(
          type: ApiExceptionType.unknown,
          code: response.statusCode,
          message: responseMessage,
          error: responseErrors,
        );
    }
  }
}
