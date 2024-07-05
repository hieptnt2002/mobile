import 'dart:convert';

import 'package:make_appointment_app/base/repository/base_repository.dart';
import 'package:make_appointment_app/base/repository/data_result.dart';
import 'package:make_appointment_app/data/models/medical_survey_answer.dart';
import 'package:make_appointment_app/data/models/medical_survey_question.dart';
import 'package:make_appointment_app/data/remote/medical_survey_api.dart';

class MedicalSurveyRepository extends BaseRepository {
  final MedicalSurveyApi _surveyApi;

  MedicalSurveyRepository({
    required MedicalSurveyApi surveyApi,
  }) : _surveyApi = surveyApi;
  Future<DataResult<List<MedicalSurveyQuestion>>> getMedicalSurveyQuestions({
    required int appointmentId,
  }) {
    return resultWithFuture(
      future: () async {
        final res = await _surveyApi.getMedicalSurveyQuestions(
          appointmentId: appointmentId,
        );

        final data = (jsonDecode(res) as List)
            .map(
              (json) =>
                  MedicalSurveyQuestion.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return data;
      },
    );
  }

  Future<DataResult> sendSurveyAnswers({
    required List<MedicalSurveyAnswer> surveyAnswers,
  }) {
    return resultWithFuture(
      future: () => _surveyApi.sendSurveyAnswers(surveyAnswers: surveyAnswers),
    );
  }

  Future<DataResult<List<MedicalSurveyAnswer>>> getMedicalSurveyAnswers({
    required String treatmentId,
  }) async {
    return resultWithFuture(
      future: () async {
        final res = await _surveyApi.getMedicalSurveyAnswers(
          treatmentId: treatmentId,
        );
        final surveyAnswers = (jsonDecode(res) as List)
            .map(
              (json) =>
                  MedicalSurveyAnswer.fromJson(json as Map<String, dynamic>),
            )
            .toList();
        return surveyAnswers;
      },
    );
  }
}
