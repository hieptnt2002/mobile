import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment_time.dart';
import 'package:make_appointment_app/data/models/medical_treatment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/appointment/appointment_view_model.dart';
import 'package:provider/provider.dart';

class AppointmentTimeItem extends StatelessWidget {
  final Color color;
  final DateTime date;
  final bool isFirstVisit;
  final int timeId;
  final String time;
  final MedicalTreatment? medicalTreatment;
  final AppointmentTimeStatus status;
  const AppointmentTimeItem({
    super.key,
    required this.color,
    required this.time,
    required this.status,
    required this.isFirstVisit,
    required this.medicalTreatment,
    required this.date,
    required this.timeId,
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
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
              title: context.t.appointment.logIn,
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
              if (!context.read<AppointmentViewModel>().isLoggedIn) {
                showLoginRequiredDialog(context);
                return;
              }
              Navigator.of(context).pushNamed(
                Routes.confirmAppointment,
                arguments: {
                  'appointmentViewModel': context.read<AppointmentViewModel>(),
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
