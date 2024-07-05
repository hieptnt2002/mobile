import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/local/shared_preferences_service.dart';
import 'package:make_appointment_app/data/models/user.dart';
import 'package:make_appointment_app/data/remote/auth_api.dart';

class AuthRepository extends BaseRepository {
  final AuthApi authApi;
  final AppData appData;
  final SharedPreferencesService sharedPreferencesService;

  AuthRepository({
    required this.appData,
    required this.authApi,
    required this.sharedPreferencesService,
  });

  Future<DataResult<UserAndToken>> login({
    required String username,
    required String password,
  }) async {
    return resultWithFuture(
      future: () async {
        final result = await authApi.login(
          email: username,
          password: password,
        );
        return UserAndToken.fromJson(result);
      },
    );
  }

  Future<DataResult<dynamic>> register({
    required String email,
    required String password,
  }) async {
    return resultWithFuture(
      future: () async {
        return authApi.register(email: email, password: password);
      },
    );
  }

  Future<DataResult<dynamic>> verifyEmailRegister({
    required String code,
  }) async {
    return resultWithFuture(
      future: () async {
        return authApi.verifyEmailRegister(code: code);
      },
    );
  }

  Future<DataResult<dynamic>> logOut() {
    return resultWithFuture(
      future: () async {
        return authApi.logOut();
      },
    );
  }

  Future<DataResult<dynamic>> resetPassword({
    required String email,
  }) async {
    return resultWithFuture(
      future: () async {
        return authApi.resetPassword(email: email);
      },
    );
  }

  Future<DataResult<dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    return resultWithFuture(
      future: () async {
        return authApi.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          token: token,
        );
      },
    );
  }
}
