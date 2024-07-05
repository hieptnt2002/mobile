enum ApiExceptionType {
  network,
  mapping,
  unauthorized,
  cancel,
  timeout,
  server,
  tokenExpires,
  serverRetry,
  serverValidate,
  invalidInput,
  unknown,
}

class ApiException implements Exception {
  final ApiExceptionType type;
  final String? message;
  final int code;
  final String? title;
  final dynamic error;

  ApiException({
    required this.type,
    required this.code,
    this.message,
    this.title,
    this.error,
  });

  @override
  String toString() {
    return 'Type: $type   Message:$message   Code: $code   e: $error';
  }
}
