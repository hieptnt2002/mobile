import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/treatment/dialog/medical_survey_answer_dialog.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_list/treatment_list_view_model.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class PendingTreatmentItem extends StatefulWidget {
  final Appointment appointment;

  const PendingTreatmentItem({super.key, required this.appointment});

  @override
  State<PendingTreatmentItem> createState() => _PendingTreatmentItemState();
}

class _PendingTreatmentItemState extends State<PendingTreatmentItem> {
  late final _viewModel = context.read<TreatmentListViewModel>();
  Appointment get _appointment => widget.appointment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateInfo(context),
          const SizedBox(height: 8),
          Text(
            '${_appointment.medicalTreatment.name} (${_appointment.appointmentType.name})',
            style: AppTextStyle.w700TextColor16Px,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _appointment.questionnaireFlg
                    ? _buildActionOutlineButton(
                        title: context.t.treatment.interviewSheet,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MedicalSurveyAnswerDialog(
                                appointment: _appointment,
                              );
                            },
                          );
                        },
                      )
                    : _buildActionButton(
                        title: context.t.treatment.medicalQuestionnaire,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.medicalSurveyQuestion,
                            arguments: _appointment,
                          );
                        },
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  title: context.t.treatment.startOfTreatment,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              _buildTreatmentDetailButton(context),
            ],
          ),
          const SizedBox(height: 8),
          _buildReminder(),
        ],
      ),
    );
  }

  Widget _buildReminder() {
    if (_appointment.questionnaireFlg) {
      return Text(
        context.t.treatment.reminderScheduledTime,
        style: AppTextStyle.bodyXSmall,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.treatment.reminderMedicalQuestionnaire,
          style: AppTextStyle.redBodyXSmall,
        ),
        Text(
          context.t.treatment.reminderStartDateAndTime,
          style: AppTextStyle.redBodyXSmall,
        ),
      ],
    );
  }

  IconButton _buildTreatmentDetailButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await Navigator.pushNamed(
          context,
          Routes.treatmentDetails,
          arguments: _appointment,
        );
        //reload list appointment
        if (result != null && result is bool && result && mounted) {
          _viewModel.getAllAppointment();
        }
      },
      style: IconButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(width: 1, color: AppColors.lightGray),
        ),
        fixedSize: const Size.fromHeight(48),
      ),
      icon: const Icon(Icons.assignment, color: AppColors.darkGray),
    );
  }

  Widget _buildActionButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: AppColors.cyan,
        fixedSize: const Size.fromHeight(48),
      ),
      child: Text(
        title,
        style: AppTextStyle.w700White14Px,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionOutlineButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(width: 1, color: AppColors.lightGray),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        fixedSize: const Size.fromHeight(48),
      ),
      child: Text(
        title,
        style: AppTextStyle.w700TextColor14Px,
        textAlign: TextAlign.center,
      ),
    );
  }

  RichText _buildDateInfo(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: Utils.formatDateWithWeekday(
              _appointment.bookingDate,
            ),
          ),
          TextSpan(
            text: ' ${_appointment.time.startTime}',
          ),
          TextSpan(
            text: ' - ${_appointment.time.endTime}',
          ),
        ],
        style: AppTextStyle.bodyXSmall,
      ),
    );
  }
}
