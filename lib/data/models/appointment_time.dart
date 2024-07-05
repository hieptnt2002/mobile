// ignore: constant_identifier_names
enum AppointmentTimeStatus { NONE, CLOSE, ALERT, AVAILABLE }

class AppointmentTime {
  final int timeId;
  AppointmentTimeStatus status;
  final String time;
  AppointmentTime({
    required this.timeId,
    required this.status,
    required this.time,
  });

  factory AppointmentTime.fromJson(Map<String, dynamic> json) {
    return AppointmentTime(
      timeId: json['time_id'],
      status: AppointmentTimeStatus.values.byName(json['status']),
      time: json['time'],
    );
  }
}
