import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/line_dash/line_dash.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/resources/route_manager.dart';
import 'package:make_appointment_app/presentation/screens/treatment/dialog/medical_survey_answer_dialog.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_details/dialog/select_cancellation_reason_dialog.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_details/dialog/cancellation_reason_view_model.dart';
import 'package:make_appointment_app/presentation/screens/treatment/treatment_details/dialog/confirm_cancellation_reason_dialog.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class TreatmentDetailsScreen extends StatefulWidget {
  final Appointment appointment;
  const TreatmentDetailsScreen({super.key, required this.appointment});

  @override
  State<TreatmentDetailsScreen> createState() => _TreatmentDetailsScreenState();
}

class _TreatmentDetailsScreenState extends State<TreatmentDetailsScreen> {
  Appointment get _appointment => widget.appointment;

  void _handleCancelButton() async {
    List<String>? cancellationReasons = await showDialog(
      context: context,
      builder: (context) => const SelectCancellationReasonDialog(),
    );
    if (cancellationReasons != null && mounted) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => CancellationReasonViewModel(),
            child: ConfirmCancellationReasonDialog(
              reasons: cancellationReasons,
              appointment: _appointment,
            ),
          );
        },
      );

      if (result != null && result is bool && result && mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.treatment.appBarTitleTreatmentDetails),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            _appointment.medicalTreatment.name,
            style: AppTextStyle.headingXSmall,
          ),
          _buildDateInfo(),
          const LineDash(height: 0.5),
          const SizedBox(height: 16),
          _buildReminder(),
          const SizedBox(height: 16),
          _appointment.questionnaireFlg
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
              : CommonButton(
                  title: context.t.treatment.medicalQuestionnaire,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.medicalSurveyQuestion,
                      arguments: _appointment,
                    );
                  },
                  buttonType: ButtonType.info,
                ),
          const SizedBox(height: 16),
          CommonButton(
            title: context.t.treatment.startOfTreatment,
            onPressed: () {},
            buttonType: ButtonType.info,
          ),
          const SizedBox(height: 16),
          _buildActionOutlineButton(
            title: context.t.treatment.changeDateAndTime,
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.updateAppointment,
                arguments: {'appointment': _appointment},
              );
            },
          ),
          const SizedBox(height: 16),
          _buildCancelButton(),
        ],
      ),
    );
  }

  Widget _buildDateInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              context.t.treatment.treatmentStartDateAndTime,
              style: AppTextStyle.w700TextColor14Px,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Utils.formatDateWithWeekday(_appointment.bookingDate),
                  ),
                  TextSpan(
                    text: ' ${_appointment.time.startTime}',
                  ),
                  TextSpan(
                    text: ' - ${_appointment.time.endTime}',
                  ),
                ],
                style: AppTextStyle.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return InkWell(
      onTap: () {
        _handleCancelButton();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        child: Text(
          context.t.treatment.cancelAppointment,
          style: AppTextStyle.w700Turquoise14Px,
        ),
      ),
    );
  }

  Widget _buildReminder() {
    if (_appointment.questionnaireFlg) {
      return Column(
        children: [
          Text(
            context.t.treatment.reminderOpenVideoTool,
            style: AppTextStyle.w700TextColor16Px,
          ),
          Text(
            context
                .t.treatment.reminderTurnOnVideoAndAudioToStartTheConsultation,
            style: AppTextStyle.w700TextColor16Px,
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.treatment.reminderMedicalQuestionnaire,
          style: AppTextStyle.w700Red16Px,
        ),
        Text(
          context.t.treatment.reminderStartDateAndTime,
          style: AppTextStyle.w700Red16Px,
        ),
      ],
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
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(width: 1, color: AppColors.lightGray),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        fixedSize: const Size.fromHeight(62),
      ),
      child: Text(
        title,
        style: AppTextStyle.headingXSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
