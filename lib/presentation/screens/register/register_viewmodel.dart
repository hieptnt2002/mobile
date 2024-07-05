import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

class RegisterViewModel extends BaseViewModel {
  final authRepository = locator.get<AuthRepository>();

  void register({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) {
    handleTask(
      showErrorDialog: false,
      onRequest: () =>
          authRepository.register(email: email, password: password),
      onSuccess: (data) {
        onSuccess();
      },
      onError: (error) {
        var exception = error.exception;
        String message = '';
        if (exception is ApiException) {
          message = exception.message ?? '';
          if (exception.code == 422 &&
              exception.error is Map<String, dynamic>) {
            var errorMap = exception.error as Map<String, dynamic>;
            var messageError = '';
            errorMap.forEach((key, value) {
              messageError =
                  '$messageError$key: ${value.toString().replaceAll('_', ' ').toLowerCase()}\n';
            });
            message = messageError.trim();
          }
        }
        onError(message);
      },
    );
  }
}
