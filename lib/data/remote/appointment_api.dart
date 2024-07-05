import 'package:intl/intl.dart';
import 'package:make_appointment_app/base/data/remote/api.dart';

class AppointmentApi {
  Future<dynamic> createAppointment({
    required int medicalId,
    required int timeId,
    required DateTime date,
    required bool isFirstVisit,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.post,
      url: '/user/appointments',
      body: {
        'service_id': medicalId,
        'appointment_type': isFirstVisit ? 'FIRST' : 'RETURN',
        'reservation_type': 'SCHEDULE',
        'booking_date': DateFormat('yyyy-MM-dd').format(date),
        'time_id': timeId,
        'payment_method': 'CREDIT_CARD',
      },
    );
  }

  Future<dynamic> updateAppointment({
    required int appointmentId,
    required int medicalId,
    required int timeId,
    required DateTime date,
    required bool isFirstVisit,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.put,
      url: '/user/appointments/$appointmentId',
      body: {
        'service_id': medicalId,
        'appointment_type': isFirstVisit ? 'FIRST' : 'RETURN',
        'reservation_type': 'SCHEDULE',
        'booking_date': DateFormat('yyyy-MM-dd').format(date),
        'time_id': timeId,
        'payment_method': 'CREDIT_CARD',
      },
    );
  }

  Future<dynamic> getAllAppointmentTimeInDate({
    required DateTime date,
    required int medicalTreatmentId,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.get,
      url: '/reservation-timetables',
      queryParameters: {
        'mode': 'ONE_DATE',
        'date': DateFormat('yyyy-MM-dd').format(date),
        'serviceId': '$medicalTreatmentId',
      },
    );
  }

  Future<dynamic> getAllAppointment() async {
    return Api.request(
      httpMethod: HttpMethod.get,
      url: '/user/appointments',
    );
  }

  Future<dynamic> cancelAppointmentById({
    required int appointmentId,
    required String cancelReasons,
  }) async {
    return Api.request(
      httpMethod: HttpMethod.patch,
      url: '/user/appointments/$appointmentId',
      body: {'cancel_reason': cancelReasons},
    );
  }
}
