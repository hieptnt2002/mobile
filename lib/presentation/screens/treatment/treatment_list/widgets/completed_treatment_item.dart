import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/utils.dart';

class CompletedTreatmentItem extends StatelessWidget {
  final Appointment appointment;
  const CompletedTreatmentItem({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: Utils.formatDateWithWeekday(
                    appointment.bookingDate,
                  ),
                ),
                TextSpan(
                  text: ' ${appointment.time.startTime}',
                ),
              ],
              style: AppTextStyle.bodyXSmall,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appointment.medicalTreatment.name,
            style: AppTextStyle.w700TextColor16Px,
          ),
          Text(
            appointment.status.name,
            style: AppTextStyle.w700TextColor14Px,
          ),
        ],
      ),
    );
  }
}
