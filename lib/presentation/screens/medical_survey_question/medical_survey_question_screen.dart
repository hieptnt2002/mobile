import 'package:flutter/material.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/appointment.dart';
import 'package:make_appointment_app/presentation/components/button/common_button.dart';
import 'package:make_appointment_app/presentation/components/dialog/custom_dialog.dart';
import 'package:make_appointment_app/presentation/screens/medical_survey_question/medical_survey_question_view_model.dart';
import 'package:make_appointment_app/presentation/screens/medical_survey_question/widgets/question_item.dart';
import 'package:provider/provider.dart';

class MedicalSurveyQuestionScreen extends StatefulWidget {
  final Appointment appointment;
  const MedicalSurveyQuestionScreen({super.key, required this.appointment});

  @override
  State<MedicalSurveyQuestionScreen> createState() =>
      _MedicalSurveyQuestionScreenState();
}

class _MedicalSurveyQuestionScreenState
    extends State<MedicalSurveyQuestionScreen> {
  late MedicalSurveyQuestionViewModel _questionViewModel;

  Appointment get _appointment => widget.appointment;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _questionViewModel = context.read<MedicalSurveyQuestionViewModel>();
    _questionViewModel.getMedicalSurveyQuestions(
      appointmentId: _appointment.id,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    });
  }

  Future _showSendSurveyAnswerSuccessDialog() async {
    await Future.delayed(Duration.zero, () {
      return showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(
            title: 'Survey Completed',
            actions: [
              DialogActionButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'Close',
              ),
            ],
            content: 'Medical survey feedback submitted',
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Survey Questionnaire'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<MedicalSurveyQuestionViewModel>(
        builder: (context, _, child) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSurveyQuestionList(),
              _buildSubmitButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SliverVisibility(
      visible: _questionViewModel.isSurveyCompleted,
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
          child: CommonButton(
            onPressed: () {
              _questionViewModel.sendSurveyAnswers().then((value) async {
                if (value is Success) {
                  await _showSendSurveyAnswerSuccessDialog();
                  if (mounted) Navigator.pop(context);
                }
              });
            },
            title: 'Submit',
            buttonType: ButtonType.info,
          ),
        ),
      ),
    );
  }

  Widget _buildSurveyQuestionList() {
    final questions = _questionViewModel.visibleQuestions;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      sliver: SliverList.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          var surveyQuestion = questions[index];
          return QuestionItem(
            key: Key(surveyQuestion.id),
            medicalQuestion: surveyQuestion,
            onNextSurveyQuestion: (answeredOptions) {
              _questionViewModel.handleNextSurveyQuestion(
                answeredOptions: answeredOptions,
                surveyQuestion: surveyQuestion,
              );
              jumpToEnd();
            },
            onModifySurveyAnswer: _questionViewModel.handleModifySurveyAnswer,
          );
        },
      ),
    );
  }
}
