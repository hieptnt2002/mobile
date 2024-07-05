import 'package:flutter/widgets.dart';
import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/local/app_data.dart';
import 'package:make_appointment_app/data/models/appointment_time.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/repository/appointment_repository.dart';

class AppointmentViewModel extends BaseViewModel {
  final _appointmentRepository = locator.get<AppointmentRepository>();
  final _appData = locator.get<AppData>();
  List<MedicalTreatment> get medicalTreatmentList =>
      _appData.medicalTreatmentList;

  List<AppointmentTime> timeOfMorningAppointment = [];
  List<AppointmentTime> timeOfAfternoonAppointment = [];
  List<AppointmentTime> timeOfEveningAppointment = [];
  List<AppointmentTime> timeOfNightAppointment = [];
  List<AppointmentTime> timeOfLateNightAppointment = [];
  bool get isLoggedIn => _appData.isLoggedIn;

  Future<void> getAllAppointmentTimeInDate({
    required DateTime date,
    required int medicalTreatmentId,
  }) async {
    await handleTask(
      onRequest: () => _appointmentRepository.getAllAppointmentTimeInDate(
        date: date,
        medicalTreatmentId: medicalTreatmentId,
      ),
      onSuccess: (data) {
        handleAllAppointmentTimeData(data);
      },
    );
  }

  void clearAllAppointmentTimeInDate() async {
    timeOfLateNightAppointment.clear();
    timeOfMorningAppointment.clear();
    timeOfAfternoonAppointment.clear();
    timeOfEveningAppointment.clear();
    timeOfNightAppointment.clear();
    notifyListeners();
  }

  Future<void> createAppointment({
    required int medicalId,
    required DateTime date,
    required int timeId,
    required bool isFirstVisit,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    handleTask(
      showErrorDialog: false,
      onRequest: () => _appointmentRepository.createAppointment(
        medicalId: medicalId,
        date: date,
        timeId: timeId,
        isFirstVisit: isFirstVisit,
      ),
      onSuccess: (_) => onSuccess.call(),
      onError: (error) {
        final exception = error.exception;
        if (exception is ApiException) {
          if (exception.type == ApiExceptionType.tokenExpires) {
            onError.call(ApiExceptionType.tokenExpires.name);
          } else {
            onError.call(exception.message ?? '');
          }
        } else {
          onError.call('');
        }
      },
    );
  }

  void handleAllAppointmentTimeData(List<AppointmentTime> appointmentTimes) {
    timeOfLateNightAppointment.clear();
    timeOfMorningAppointment.clear();
    timeOfAfternoonAppointment.clear();
    timeOfEveningAppointment.clear();
    timeOfNightAppointment.clear();
    for (var e in appointmentTimes) {
      List<String> parts = e.time.split(':');
      int? hour = int.tryParse(parts[0]);
      int? minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;
      if (hour >= 21) {
        timeOfNightAppointment.add(e);
      } else if (hour >= 18) {
        timeOfEveningAppointment.add(e);
      } else if (hour >= 12) {
        timeOfAfternoonAppointment.add(e);
      } else if (hour >= 6) {
        timeOfMorningAppointment.add(e);
      } else if (hour >= 0) {
        timeOfLateNightAppointment.add(e);
      }
    }
    notifyListeners();
  }
}
