import 'package:flutter/material.dart';
import 'package:make_appointment_app/base/data/remote/api_exception.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/appointment.dart';

import 'package:make_appointment_app/data/models/medical_survey_answer.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/gen/strings.g.dart';
import 'package:make_appointment_app/presentation/components/loading/spin_kit_circle.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';
import 'package:make_appointment_app/presentation/screens/treatment/dialog/medical_survey_answer_view_model.dart';
import 'package:make_appointment_app/presentation/utils.dart';
import 'package:provider/provider.dart';

class MedicalSurveyAnswerDialog extends StatefulWidget {
  final Appointment appointment;

  const MedicalSurveyAnswerDialog({super.key, required this.appointment});

  @override
  State<MedicalSurveyAnswerDialog> createState() =>
      _MedicalSurveyAnswerDialogState();
}

class _MedicalSurveyAnswerDialogState extends State<MedicalSurveyAnswerDialog> {
  Appointment get _appointment => widget.appointment;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicalSurveyAnswerViewModel(),
      child: Consumer<MedicalSurveyAnswerViewModel>(
        builder: (context, answerViewModel, child) {
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            insetPadding: const EdgeInsets.all(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndSubTitle(),
                  _buildDivider(),
                  _buildAnswerList(answerViewModel),
                  _buildDivider(),
                  _buildCloseButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerList(MedicalSurveyAnswerViewModel answerViewModel) {
    return Flexible(
      fit: FlexFit.loose,
      child: FutureBuilder(
        future: answerViewModel.getSurveyAnswers(treatmentId: 't1'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;
            if (result is Success) {
              final surveyAnswers = result.data as List<MedicalSurveyAnswer>;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: surveyAnswers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  return _buildAnswerItem(surveyAnswers[index]);
                },
              );
            }
            if (result is Error) {
              final error = result.exception;
              String textError =
                  (error is ApiException) ? error.message ?? 'Error' : 'Error';
              return _buildTextError(textError);
            }
            return Container();
          }
          if (snapshot.hasError) _buildTextError('Error');
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildTextError(String errorText) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        errorText,
        style: AppTextStyle.redBodyMedium,
      ),
    );
  }

  Widget _buildAnswerItem(MedicalSurveyAnswer surveyAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...surveyAnswer.surveyQuestion.questionContents.map(
          (content) => _buildContentQuestion(content),
        ),
        Text(
          surveyAnswer.answerText,
          style: AppTextStyle.darkGreyBodyXSmall,
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Container(
      height: 72,
      alignment: Alignment.center,
      child: const SpinKitCircle(color: AppColors.cyan),
    );
  }

  Widget _buildContentQuestion(QuestionContent content) {
    return Text(
      content.content,
      style: AppTextStyle.w700TextColor12Px,
    );
  }

  Widget _buildTitleAndSubTitle() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            _appointment.medicalTreatment.name,
            style: AppTextStyle.headingXSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            '${Utils.formatDateWithWeekday(_appointment.bookingDate)} ${_appointment.time.startTime}',
            style: AppTextStyle.darkGrayBodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: AppColors.lightGray,
    );
  }

  Widget _buildCloseButton() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            context.t.treatment.close,
            style: AppTextStyle.cyanLabelMedium,
          ),
        ),
      ),
    );
  }
}
