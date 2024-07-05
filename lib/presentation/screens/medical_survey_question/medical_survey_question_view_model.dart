import 'package:make_appointment_app/app/injection_container.dart';
import 'package:make_appointment_app/base/presentation/base_view_model.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/data/models/medical_survey_answer.dart';
import 'package:make_appointment_app/repository/medical_survey_repository.dart';

class MedicalSurveyQuestionViewModel extends BaseViewModel {
  final MedicalSurveyRepository _surveyRepository =
      locator.get<MedicalSurveyRepository>();
  List<MedicalSurveyQuestion> surveyQuestions = [];
  List<MedicalSurveyQuestion> visibleQuestions = [];
  List<MedicalSurveyAnswer> surveyAnswers = [];
  bool isSurveyCompleted = false;

  void handleNextSurveyQuestion({
    required List<AnswerOption> answeredOptions,
    required MedicalSurveyQuestion surveyQuestion,
  }) {
    surveyAnswers.add(
      MedicalSurveyAnswer(
        id: surveyQuestion.id,
        answerText: answeredOptions.map((e) => e.answerText).join(', '),
        surveyQuestion: surveyQuestion,
      ),
    );
    String? nextQuestionId = answeredOptions.map((e) => e.nextQuestionId).last;
    if (nextQuestionId != null) {
      isSurveyCompleted = false;
      var nextQuestion = surveyQuestions
          .firstWhere((question) => question.id == nextQuestionId);
      visibleQuestions.add(nextQuestion);
    } else {
      isSurveyCompleted = true;
    }
    notifyListeners();
  }

  void handleModifySurveyAnswer(MedicalSurveyQuestion surveyQuestion) {
    isSurveyCompleted = false;
    int questionIndex = visibleQuestions.indexOf(surveyQuestion);
    visibleQuestions.removeRange(questionIndex + 1, visibleQuestions.length);

    final answerEdit = surveyAnswers
        .firstWhere((answer) => answer.surveyQuestion == surveyQuestion);
    int answerIndex = surveyAnswers.indexOf(answerEdit);
    surveyAnswers.removeRange(answerIndex, surveyAnswers.length);
    notifyListeners();
  }

  void getMedicalSurveyQuestions({required int appointmentId}) {
    handleTask(
      onRequest: () => _surveyRepository.getMedicalSurveyQuestions(
        appointmentId: appointmentId,
      ),
      onSuccess: (data) {
        surveyQuestions = data;
        visibleQuestions = [surveyQuestions.first];
        notifyListeners();
      },
    );
  }

  Future<DataResult> sendSurveyAnswers() {
    return handleTaskWithResultReturn(
      onRequest: () => _surveyRepository.sendSurveyAnswers(
        surveyAnswers: surveyAnswers,
      ),
    );
  }
}
