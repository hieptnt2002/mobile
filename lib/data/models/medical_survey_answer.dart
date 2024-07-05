import 'package:make_appointment_app/data/models/medical_survey_question.dart';

class MedicalSurveyAnswer {
  final String id;
  final String answerText;
  final MedicalSurveyQuestion surveyQuestion;

  MedicalSurveyAnswer({
    required this.id,
    required this.answerText,
    required this.surveyQuestion,
  });

  factory MedicalSurveyAnswer.fromJson(Map<String, dynamic> json) {
    return MedicalSurveyAnswer(
      id: json['id'],
      answerText: json['answerText'],
      surveyQuestion: MedicalSurveyQuestion.fromJson(json['surveyQuestion']),
    );
  }
}
