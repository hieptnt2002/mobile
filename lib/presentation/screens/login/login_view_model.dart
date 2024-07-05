import 'package:flutter/material.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

import '../../../data/local/shared_preferences_service.dart';

class LoginViewModel extends BaseViewModel {
  final authRepository = locator.get<AuthRepository>();
  final _appData = locator.get<AppData>();
  final sharedPreferencesService = locator.get<SharedPreferencesService>();

  bool get isLoggedIn => _appData.isLoggedIn;

  void login({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    handleTask(
      showErrorDialog: false,
      onRequest: () =>
          authRepository.login(username: email, password: password),
      onSuccess: (data) {
        sharedPreferencesService.setUser(data.userModel);
        sharedPreferencesService.setToken(data.jwt);
        _appData.currentUser = data.userModel;
        onSuccess();
      },
      onError: (error) {
        String? message = '';
        var exception = error.exception;
        if (exception is ApiException && exception.code == 401) {
          message = context.t.loginViewModel.message;
        }
        onError(message);
      },
    );
  }
}
