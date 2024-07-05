// ignore_for_file: constant_identifier_names

import 'package:make_appointment_app/data/models/medical_treatment.dart';

enum AppointmentStatus { NEW, ACCEPTED, CANCEL, COMPLETED }

enum AppointmentType { FIRST, RETURN }

enum ReservationType { NOW, SCHEDULE }

class Appointment {
  final int id;
  final MedicalTreatment medicalTreatment;
  final AppointmentType appointmentType;
  final ReservationType reservationType;
  final Time time;
  final DateTime bookingDate;
  final AppointmentStatus status;
  final String? paymentMethod;
  final bool questionnaireFlg;
  final String? cancelReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.medicalTreatment,
    required this.appointmentType,
    required this.reservationType,
    required this.time,
    required this.bookingDate,
    required this.status,
    this.paymentMethod,
    required this.questionnaireFlg,
    this.cancelReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      medicalTreatment: MedicalTreatment.fromJson(json['service']),
      appointmentType: AppointmentType.values.byName(json['appointment_type']),
      reservationType: ReservationType.values.byName(json['reservation_type']),
      time: Time.fromJson(json['time']),
      bookingDate: DateTime.parse(json['booking_date']),
      status: AppointmentStatus.values.byName(json['status']),
      paymentMethod: json['payment_method'],
      questionnaireFlg: json['questionnaire_flg'] == 0 ? false : true,
      cancelReason: json['cancel_reason'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Time {
  final int id;
  final String startTime;
  final String endTime;

  Time({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
