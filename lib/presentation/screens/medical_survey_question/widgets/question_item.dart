import 'package:flutter/material.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/presentation/resources/app_colors.dart';
import 'package:make_appointment_app/presentation/resources/app_images.dart';
import 'package:make_appointment_app/presentation/resources/app_text_style.dart';

import 'radio_answer.dart';
import 'checkbox_answer.dart';
import 'input_answer.dart';

class QuestionItem extends StatefulWidget {
  final MedicalSurveyQuestion medicalQuestion;
  final ValueChanged<List<AnswerOption>> onNextSurveyQuestion;
  final ValueChanged<MedicalSurveyQuestion> onModifySurveyAnswer;

  const QuestionItem({
    super.key,
    required this.medicalQuestion,
    required this.onNextSurveyQuestion,
    required this.onModifySurveyAnswer,
  });

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem>
    with AutomaticKeepAliveClientMixin {
  AnswerOption? _selectedRadioAnswer;
  final List<AnswerOption> _selectedCheckboxAnswers = [];
  final TextEditingController _textController = TextEditingController();
  bool _isError = false;
  bool _isCompleted = false;

  MedicalSurveyQuestion get _medicalQuestion => widget.medicalQuestion;
  ValueChanged<List<AnswerOption>> get _onNextSurveyQuestion =>
      widget.onNextSurveyQuestion;

  ValueChanged<MedicalSurveyQuestion> get _onModifySurveyAnswer =>
      widget.onModifySurveyAnswer;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _resetAnswerState() {
    _isCompleted = false;
    _selectedRadioAnswer = null;
    _selectedCheckboxAnswers.clear();
    _textController.clear();
  }

  void _handleContinue() {
    setState(() {
      switch (_medicalQuestion.questionType) {
        case QuestionType.radio:
          return;
        case QuestionType.checkbox:
          _isError = _selectedCheckboxAnswers.isEmpty;
          if (!_isError) {
            _isCompleted = true;
            _onNextSurveyQuestion(_selectedCheckboxAnswers);
          }
          break;
        case QuestionType.input:
          final answerText = _textController.text.trim();
          _isError = answerText.isEmpty;
          if (!_isError) {
            _isCompleted = true;
            final answered = AnswerOption(
              answerText: answerText,
              nextQuestionId: _medicalQuestion.answers.first.nextQuestionId,
            );
            _onNextSurveyQuestion([answered]);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        IgnorePointer(
          ignoring: _isCompleted,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Online Clinic',
                      style: AppTextStyle.w700Cyan14Px,
                    ),
                    _buildRequiredItem(),
                    ..._medicalQuestion.questionContents.map(
                      (content) => _buildContentItem(content),
                    ),
                    _buildAnswers(),
                    if (_isError) _buildError(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildActionButton(),
      ],
    );
  }

  Widget _buildRequiredItem() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.red,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: const Text(
        'Required Item',
        style: AppTextStyle.w700White10Px,
      ),
    );
  }

  Widget _buildContentItem(QuestionContent content) {
    return Padding(
      padding: content.isEmphasized
          ? const EdgeInsets.symmetric(vertical: 12.0)
          : const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content.content,
        style: content.isEmphasized
            ? AppTextStyle.w700TextColor12Px
            : AppTextStyle.bodyXSmall,
      ),
    );
  }

  Container _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          AppImages.picAvatar,
          width: 48,
          height: 48,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (_isCompleted) return _buildModifyButton();
    if (_medicalQuestion.questionType == QuestionType.radio) {
      return const SizedBox();
    }
    return _buildContinueButton();
  }

  Widget _buildModifyButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          setState(() {
            _resetAnswerState();
            _onModifySurveyAnswer(_medicalQuestion);
          });
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1, color: AppColors.lightGray),
          ),
          child: const Text(
            'Fix it',
            style: AppTextStyle.bodyXSmall,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          _handleContinue();
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.cyan,
          ),
          child: const Text(
            'Continue',
            style: AppTextStyle.whiteBodyXSmall,
          ),
        ),
      ),
    );
  }

  Widget _buildAnswers() {
    switch (_medicalQuestion.questionType) {
      case QuestionType.radio:
        return RadioAnswer(
          options: _medicalQuestion.answers,
          selectedAnswer: _selectedRadioAnswer,
          onChanged: (value) {
            setState(() {
              _selectedRadioAnswer = value;
              _isCompleted = true;
              _onNextSurveyQuestion([_selectedRadioAnswer!]);
            });
          },
        );
      case QuestionType.checkbox:
        return CheckboxAnswer(
          options: _medicalQuestion.answers,
          selectedAnswers: _selectedCheckboxAnswers,
          onChanged: (answer) {
            setState(() {
              if (_selectedCheckboxAnswers.contains(answer)) {
                _selectedCheckboxAnswers.remove(answer);
              } else {
                _selectedCheckboxAnswers.add(answer);
              }
            });
          },
        );
      case QuestionType.input:
        return InputAnswer(
          controller: _textController,
          enabled: !_isCompleted,
        );
    }
  }

  Widget _buildError() {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        'Required fields',
        style: AppTextStyle.redBodyXSmall,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
