import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';

class RadioAnswer extends StatelessWidget {
  final List<AnswerOption> options;
  final AnswerOption? selectedAnswer;
  final ValueChanged<AnswerOption?> onChanged;

  const RadioAnswer({
    Key? key,
    required this.options,
    required this.selectedAnswer,
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
          return RadioListTile<AnswerOption>(
            contentPadding: const EdgeInsets.only(right: 20),
            value: answer,
            groupValue: selectedAnswer,
            activeColor: AppColors.cyan,
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.cyan;
              }
              return AppColors.lightGray;
            }),
            onChanged: onChanged,
            dense: true,
            title: Text(answer.answerText ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
