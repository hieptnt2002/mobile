import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/repository/appointment_repository.dart';

class CancellationReasonViewModel extends BaseViewModel {
  final AppointmentRepository _appointmentRepository =
      locator.get<AppointmentRepository>();

  Future<DataResult> cancelAppointmentById({
    required int appointmentId,
    required String cancelReasons,
    required OnSuccess onSuccess,
    required Function(String) onError,
  }) async {
    return handleTaskWithResultReturn(
      showErrorDialog: false,
      onRequest: () => _appointmentRepository.cancelAppointmentById(
        appointmentId: appointmentId,
        cancelReasons: cancelReasons,
      ),
      onSuccess: onSuccess,
      onError: (err) {
        String? message;
        var exception = err.exception;
        if (exception is ApiException) {
          message = exception.message;
        }
        onError(message ?? 'An error has occurred');
      },
    );
  }
}
