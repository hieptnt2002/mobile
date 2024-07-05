import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class CheckboxAnswer extends StatelessWidget {
  final List<AnswerOption> options;
  final List<AnswerOption> selectedAnswers;
  final ValueChanged<AnswerOption> onChanged;

  const CheckboxAnswer({
    Key? key,
    required this.options,
    required this.selectedAnswers,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Column(
        children: options.map((answer) {
          return CheckboxListTile(
            contentPadding: const EdgeInsets.only(right: 20),
            value: selectedAnswers.contains(answer),
            activeColor: AppColors.cyan,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              onChanged(answer);
            },
            dense: true,
            title: Text(answer.answerText ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
