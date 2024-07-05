import 'package:flutter/material.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final authRepository = locator.get<AuthRepository>();
  final _appData = locator.get<AppData>();
  bool get isLoggedIn => _appData.isLoggedIn;
  void changePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
    required VoidCallback onSuccess,
    required Function() onError,
  }) {
    handleTask(
      onRequest: () => authRepository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        token: token,
      ),
      onSuccess: (data) {
        onSuccess();
      },
      onError: (error) {
        onError();
      },
    );
  }
}
