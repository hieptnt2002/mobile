import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/repository/appointment_repository.dart';

class TreatmentListViewModel extends BaseViewModel {
  final _appointmentRepository = locator.get<AppointmentRepository>();
  List<Appointment> completedAppointments = [];
  List<Appointment> pendingAppointments = [];
  TreatmentListViewModel() {
    getAllAppointment();
  }

  void getAllAppointment() async {
    handleTask(
      onRequest: _appointmentRepository.getAllAppointment,
      onSuccess: (appointments) {
        pendingAppointments.clear();
        completedAppointments.clear();
        for (var appointment in appointments) {
          if (appointment.status == AppointmentStatus.NEW ||
              appointment.status == AppointmentStatus.ACCEPTED) {
            pendingAppointments.add(appointment);
          } else {
            completedAppointments.add(appointment);
          }
        }
        notifyListeners();
      },
    );
  }
}
