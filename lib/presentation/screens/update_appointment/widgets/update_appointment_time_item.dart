import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment_time.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/update_appointment/update_appointment_view_model.dart';
import 'package:provider/provider.dart';

class UpdateAppointmentTimeItem extends StatelessWidget {
  final Color color;
  final DateTime date;
  final bool isFirstVisit;
  final int timeId;
  final String time;
  final MedicalTreatment? medicalTreatment;
  final AppointmentTimeStatus status;
  final int appointmentId;
  const UpdateAppointmentTimeItem({
    super.key,
    required this.color,
    required this.time,
    required this.status,
    required this.isFirstVisit,
    required this.medicalTreatment,
    required this.date,
    required this.timeId,
    required this.appointmentId,
  });
  void showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: context.t.appointment.loginRequiredTitleDialog,
          content: context.t.appointment.loginRequiredContentDialog,
          actions: [
            DialogActionButton(
              onTap: () => Navigator.of(context).pop(),
              title: context.t.appointment.ok,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = time.substring(0, 5);
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: status == AppointmentTimeStatus.CLOSE ||
              status == AppointmentTimeStatus.NONE
          ? null
          : () {
              if (!context.read<UpdateAppointmentViewModel>().isLoggedIn) {
                showLoginRequiredDialog(context);
                return;
              }
              Navigator.of(context).pushNamed(
                Routes.confirmUpdateAppointment,
                arguments: {
                  'updateAppointmentViewModel':
                      context.read<UpdateAppointmentViewModel>(),
                  'appointmentId': appointmentId,
                  'isFirstVisit': isFirstVisit,
                  'time': time,
                  'timeId': timeId,
                  'date': date,
                  'medicalTreatment': medicalTreatment,
                },
              );
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyle.bodyMedium.copyWith(color: color),
        ),
      ),
    );
  }
}
