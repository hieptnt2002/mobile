import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/data/models/appointment_time.dart';
import 'package:make_appointment_app/data/remote/appointment_api.dart';

class AppointmentRepository extends BaseRepository {
  final AppointmentApi _appointmentApi;
  AppointmentRepository({required AppointmentApi appointmentApi})
      : _appointmentApi = appointmentApi;

  Future<DataResult<List<AppointmentTime>>> getAllAppointmentTimeInDate({
    required DateTime date,
    required int medicalTreatmentId,
  }) async {
    return resultWithFuture(
      future: () async {
        final json = await _appointmentApi.getAllAppointmentTimeInDate(
          date: date,
          medicalTreatmentId: medicalTreatmentId,
        );
        return ((((json['date_list'] ?? []) as List).first['appointments'] ??
                []) as List<dynamic>)
            .map((e) => AppointmentTime.fromJson(e))
            .toList();
      },
    );
  }

  Future<DataResult> createAppointment({
    required int medicalId,
    required DateTime date,
    required int timeId,
    required bool isFirstVisit,
  }) async {
    return resultWithFuture(
      future: () async {
        return _appointmentApi.createAppointment(
          medicalId: medicalId,
          timeId: timeId,
          date: date,
          isFirstVisit: isFirstVisit,
        );
      },
    );
  }

  Future<DataResult> updateAppointment({
    required int appointmentId,
    required int medicalId,
    required DateTime date,
    required int timeId,
    required bool isFirstVisit,
  }) async {
    return resultWithFuture(
      future: () async {
        return _appointmentApi.updateAppointment(
          appointmentId: appointmentId,
          medicalId: medicalId,
          timeId: timeId,
          date: date,
          isFirstVisit: isFirstVisit,
        );
      },
    );
  }

  Future<DataResult<List<Appointment>>> getAllAppointment() {
    return resultWithFuture(
      future: () async {
        final result =
            await _appointmentApi.getAllAppointment() as List<dynamic>;
        return result
            .map((json) => Appointment.fromJson(json as Map<String, dynamic>))
            .toList();
      },
    );
  }

  Future<DataResult<dynamic>> cancelAppointmentById({
    required int appointmentId,
    required String cancelReasons,
  }) async {
    return resultWithFuture(
      future: () {
        return _appointmentApi.cancelAppointmentById(
          appointmentId: appointmentId,
          cancelReasons: cancelReasons,
        );
      },
    );
  }
}
