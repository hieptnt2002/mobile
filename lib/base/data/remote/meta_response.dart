class MetaResponse {
  final int success;
  final bool status;
  final dynamic errors;
  final int code;
  final String? message;

  MetaResponse({
    required this.success,
    required this.status,
    required this.code,
    required this.message,
    required this.errors,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) {
    return MetaResponse(
      success: json['success'] ?? 0,
      status: json['status'] ?? false,
      errors: json['errors'] ?? {},
      code: json['code'] ?? 500,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'errors': errors,
      'code': code,
      'message': message,
    };
  }
}

class BaseApiResponse {
  final MetaResponse meta;
  final dynamic data;

  BaseApiResponse({
    required this.meta,
    required this.data,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) {
    return BaseApiResponse(
      meta: MetaResponse.fromJson(json['meta']),
      data: json['data'],
    );
  }
}
