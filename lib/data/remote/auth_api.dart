import 'package:make_appointment_app/base/data/remote/api.dart';

class AuthApi {
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/login',
      body: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<dynamic> register({
    required String email,
    required String password,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/register',
      body: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<dynamic> verifyEmailRegister({
    required String code,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/email-verification/$code',
      body: {
        'code': code,
      },
    );
  }

  Future<dynamic> logOut() {
    return Api.request(httpMethod: HttpMethod.post, url: '/logout', body: {});
  }

  Future<dynamic> resetPassword({
    required String email,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/change-password/email-confirm',
      body: {
        'email': email,
      },
    );
  }

  Future<dynamic> changePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/change-password/update',
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
        'token': token,
      },
    );
  }
}
