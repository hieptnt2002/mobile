import 'package:flutter/material.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final authRepository = locator.get<AuthRepository>();

  void resetPassword({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    handleTask(
      showErrorDialog: false,
      onRequest: () => authRepository.resetPassword(email: email),
      onSuccess: (data) {
        onSuccess();
      },
      onError: (error) {
        var exception = error.exception;
        String message = '';
        if (exception is ApiException && exception.code == 404) {
          message = context.t.forgotPassword.viewModelMessage404;
        }
        onError(message);
      },
    );
  }
}
