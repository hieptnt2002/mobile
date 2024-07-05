import 'dart:ui';

import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/repository/auth_repository.dart';

class VerifyEmailViewModel extends BaseViewModel {
  final _authRepository = locator.get<AuthRepository>();
  void verifyEmailRegister({
    required String code,
    required VoidCallback onSuccess,
  }) {
    handleTask(
      onRequest: () => _authRepository.verifyEmailRegister(code: code),
      onSuccess: (data) {
        onSuccess();
      },
      onError: (error) {},
    );
  }
}
